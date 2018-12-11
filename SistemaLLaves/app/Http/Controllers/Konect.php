<?php

//con este metodo generamos la conexion con la base de datos con el usuario keySystem el cual solo tiene permiso de SELECT y EXECUTE en los precedimientos
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