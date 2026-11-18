<?php
abstract class Animal {
    public $name;

    public function __construct($name) {
        $this->name = $name;
    }

    abstract public function speak();

    public function describe() {
        return "Te zwięrzę nazywa się " . $this->name;
    }

}

class Cat extends Animal{
    public function speak(){
        return "miał ";
    }

    public function __construct($name) {
        parent::__construct($name);
    }
    
}


$cat = new Cat("Mleczak ","robi miał ");
echo $cat->speak();
echo $cat->describe();
