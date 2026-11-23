
<?php

interface sqlinterface {
    public function FindAll($table);
    public function Find($table, $id);
    public function ReadOne($table, $id);
    public function ReadFirstTen($table);
}

abstract class database {
    protected $connection;

    public function connect() {
        $this->connection = mysqli_connect("localhost", "root", "", "test");
        return $this->connection;
    }

    abstract public function createDatabase($name);
    abstract public function createTable($sql);
    abstract public function readTable($table);
    abstract public function updateTable($sql, $params);
    abstract public function deleteTable($table);
}

class mysqldb extends database implements sqlinterface {

    public function createDatabase($name) {
        return mysqli_query($this->connection, "CREATE DATABASE IF NOT EXISTS $name");
    }

    public function createTable($sql) {
        return mysqli_query($this->connection, $sql);
    }

    public function readTable($table) {
        return mysqli_query($this->connection, "SELECT * FROM $table");
    }

    public function updateTable($sql, $params) {
        $stmt = mysqli_prepare($this->connection, $sql);
        mysqli_stmt_bind_param($stmt, str_repeat("s", count($params)), ...$params);
        return mysqli_stmt_execute($stmt);
    }

    public function deleteTable($table) {
        return mysqli_query($this->connection, "DROP TABLE $table");
    }

    public function FindAll($table) {
        return $this->readTable($table);
    }

    public function Find($table, $id) {
        $stmt = mysqli_prepare($this->connection, "SELECT * FROM $table WHERE id = ?");
        mysqli_stmt_bind_param($stmt, "i", $id);
        mysqli_stmt_execute($stmt);
        return mysqli_stmt_get_result($stmt);
    }

    public function ReadOne($table, $id) {
        return mysqli_fetch_assoc($this->Find($table, $id));
    }

    public function ReadFirstTen($table) {
        return mysqli_query($this->connection, "SELECT * FROM $table LIMIT 10");
    }
}

class TestDatabase {
    public function test($result, $name) {
        echo $result ? "[OK] $name<br>" : "[BLAD] $name<br>";
    }
}

$db = new mysqldb();
$test = new TestDatabase();

$db->connect();
$test->test($db->connect(), "Polaczenie");

$db->createDatabase("test");

mysqli_select_db($db->connect(), "test");

$db->createTable("CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
)");

$test->test($db->updateTable(
    "INSERT INTO users (name, email) VALUES (?, ?)",
    ["Jan", "jan@test.pl"]
), "Dodawanie");

$test->test($db->FindAll("users"), "FindAll");
$test->test($db->Find("users", 1), "Find");
$test->test($db->ReadOne("users", 1), "ReadOne");
$test->test($db->ReadFirstTen("users"), "ReadFirstTen");

$test->test($db->updateTable(
    "UPDATE users SET name = ? WHERE id = ?",
    ["Adam", 1]
), "Aktualizacja");

$test->test($db->readTable("users"), "Odczyt");
$test->test($db->deleteTable("users"), "Usuwanie");

?>
