<?php
interface Render{
    public function jamnik($jamnik);
}

interface Json{
    public function cos($jeden, $dwa);
}

class Renderer implements Render{
    public function jamnik($jamnik){
        return $jamnik;
    }
}

class Product implements Json{
    public function cos($jeden, $dwa){
        print_r($data = [$jeden,$dwa]);
    }
}

$renderer = new Renderer();
echo $renderer->jamnik("Jamnik");

$data = new Product();
echo $data->cos("Jeden","Dwa");




interface Drivable{
    public function drive();
}

class Car implements Drivable{
    public function drive(){
        return "samochód robi vroom";
    }
}

class Bike implements Drivable{
    public function drive(){
        return "motor nie robi vroom";
    }
}
