<?php

function conectar(){
    $username="keySystem";
    $password="keySystem";

    $cs = "mysql:host=localhost;dbname=sistema_llaves;charset=utf8";
    try{
        $conection = new PDO($cs,$username,$password);
        return $conection;
    }catch(PDOException $e){
        return $e->getMessage();
    }
}