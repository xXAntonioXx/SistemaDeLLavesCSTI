<?php

function hola(){
    $servername="localhost";
    $username="keySystem";
    $password="keySystem";
    $dbname="sistema_llaves";
    $charset="utf8mb4";

    $cs = "mysql:host=localhost;dbname=sistema_llaves";
    try{
        $conection = new PDO($cs,$username,$password);
        return $conection;
    }catch(PDOException $e){
        return $e->getMessage();
    }
    return "hola";
}