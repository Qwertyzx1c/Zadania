<?php

interface Renderable
{
    public function render(): string;
}

class HtmlElement implements Renderable
{
    private string $content;

    public function __construct(string $content)
    {
        $this->content = $content;
    }

    public function render(): string
    {
        return "<div>{$this->content}</div>";
    }
}

$html = new HtmlElement("Hello World");
echo $html->render();



interface JsonSerializable
{
    public function jsonSerialize(): array;
}

class User implements JsonSerializable
{
    private string $name;
    private int $age;

    public function __construct(string $name, int $age)
    {
        $this->name = $name;
        $this->age = $age;
    }

    public function jsonSerialize(): array
    {
        return [
            "name" => $this->name,
            "age" => $this->age
        ];
    }
}

$user = new User("Jan", 25);

print_r($user->jsonSerialize());


interface Drivable
{
    public function drive(): string;
}

class Car implements Drivable
{
    public function drive(): string
    {
        return "Samochód jedzie po drodze.";
    }
}

class Bike implements Drivable
{
    public function drive(): string
    {
        return "Rower jedzie po ścieżce rowerowej.";
    }
}

$car = new Car();
$bike = new Bike();

echo $car->drive() . "\n";
echo $bike->drive() . "\n";


class Product implements JsonSerializable
{
    private string $name;
    private float $price;
    private int $quantity;

    public function __construct(string $name, float $price, int $quantity)
    {
        $this->name = $name;
        $this->price = $price;
        $this->quantity = $quantity;
    }

    public function jsonSerialize(): array
    {
        return [
            "name" => $this->name,
            "price" => $this->price,
            "quantity" => $this->quantity
        ];
    }
}

$product = new Product("Laptop", 3500.00, 5);

print_r($product->jsonSerialize());


