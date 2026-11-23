
<?php

// INTERFEJS
interface sqlinterface
{
    public function FindAll($table);
    public function Find($table, $id);
    public function ReadOne($table, $id);
    public function ReadFirstTen($table);
}


// KLASA ABSTRAKCYJNA
abstract class database
{
    protected $host = "localhost";
    protected $user = "root";
    protected $password = "";
    protected $dbname = "test";

    protected $connection;

    public function connect()
    {
        $this->connection = mysqli_connect(
            $this->host,
            $this->user,
            $this->password
        );

        if (!$this->connection) {
            die("Blad polaczenia: " . mysqli_connect_error());
        }

        return true;
    }

    abstract public function createDatabase($name);
    abstract public function createTable($sql);
    abstract public function readTable($table);
    abstract public function updateTable($sql, $params);
    abstract public function deleteTable($table);
}


// KLASA MYSQLDB
class mysqldb extends database implements sqlinterface
{
    public function createDatabase($name)
    {
        $sql = "CREATE DATABASE IF NOT EXISTS `$name`";

        return mysqli_query($this->connection, $sql);
    }

    public function createTable($sql)
    {
        return mysqli_query($this->connection, $sql);
    }

    public function readTable($table)
    {
        return mysqli_query(
            $this->connection,
            "SELECT * FROM `$table`"
        );
    }

    public function updateTable($sql, $params)
    {
        $stmt = mysqli_prepare($this->connection, $sql);

        if (!$stmt) {
            return false;
        }

        $types = str_repeat("s", count($params));

        if (!empty($params)) {
            mysqli_stmt_bind_param($stmt, $types, ...$params);
        }

        $result = mysqli_stmt_execute($stmt);

        mysqli_stmt_close($stmt);

        return $result;
    }

    public function deleteTable($table)
    {
        return mysqli_query(
            $this->connection,
            "DROP TABLE IF EXISTS `$table`"
        );
    }


    // METODY INTERFEJSU

    public function FindAll($table)
    {
        return $this->readTable($table);
    }

    public function Find($table, $id)
    {
        $sql = "SELECT * FROM `$table` WHERE id = ?";

        $stmt = mysqli_prepare($this->connection, $sql);

        mysqli_stmt_bind_param($stmt, "i", $id);

        mysqli_stmt_execute($stmt);

        $result = mysqli_stmt_get_result($stmt);

        mysqli_stmt_close($stmt);

        return $result;
    }

    public function ReadOne($table, $id)
    {
        $result = $this->Find($table, $id);

        return mysqli_fetch_assoc($result);
    }

    public function ReadFirstTen($table)
    {
        return mysqli_query(
            $this->connection,
            "SELECT * FROM `$table` LIMIT 10"
        );
    }
}


// KLASA TESTUJACA
class TestDatabase
{
    public function test($result, $name)
    {
        if ($result) {
            echo "<p style='color:green'>[OK] $name</p>";
        } else {
            echo "<p style='color:red'>[BLAD] $name</p>";
        }
    }
}


// URUCHOMIENIE PROGRAMU

$db = new mysqldb();
$test = new TestDatabase();

echo "<h2>TESTOWANIE MYSQLDB</h2>";

// Polaczenie
$db->connect();
$test->test(true, "Polaczenie z MySQL");

// Tworzenie bazy
$result = $db->createDatabase("test");
$test->test($result, "Tworzenie bazy danych");

// Wybranie bazy
mysqli_select_db($db->connect(), "test");

// Tworzenie tabeli
$sql = "CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
)";

$result = $db->createTable($sql);
$test->test($result, "Tworzenie tabeli");

// Dodawanie danych
$result = $db->updateTable(
    "INSERT INTO users (name, email) VALUES (?, ?)",
    ["Jan", "jan@test.pl"]
);

$test->test($result, "Dodawanie danych");

// FindAll
$result = $db->FindAll("users");
$test->test($result, "FindAll");

while ($row = mysqli_fetch_assoc($result)) {
    print_r($row);
    echo "<br>";
}

// Find
$result = $db->Find("users", 1);
$test->test($result, "Find");

// ReadOne
$result = $db->ReadOne("users", 1);
$test->test($result !== null, "ReadOne");

echo "<pre>";
print_r($result);
echo "</pre>";

// ReadFirstTen
$result = $db->ReadFirstTen("users");
$test->test($result, "ReadFirstTen");

// Aktualizacja
$result = $db->updateTable(
    "UPDATE users SET name = ? WHERE id = ?",
    ["Adam", 1]
);

$test->test($result, "Aktualizacja danych");

// Odczyt tabeli
$result = $db->readTable("users");
$test->test($result, "Odczytywanie tabeli");

// Usuwanie tabeli
$result = $db->deleteTable("users");
$test->test($result, "Usuwanie tabeli");

?>
