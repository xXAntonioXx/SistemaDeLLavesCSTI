<?php

//con este metodo generamos la conexion con la base de datos con el usuario keySystem el cual solo tiene permiso de SELECT y EXECUTE en los precedimientos
function conectar(){
    $username = env('DB_USERNAME');
    $password = env('DB_PASSWORD');
    $dataBase = env('DB_DATABASE');
    $host = env('DB_HOST');
    
    $cs = "mysql:host={$host};dbname={$dataBase};charset=utf8";
    try{
        $conection = new PDO($cs,$username,$password);
        return $conection;
    }catch(PDOException $e){
        return $e->getMessage();
    }
}