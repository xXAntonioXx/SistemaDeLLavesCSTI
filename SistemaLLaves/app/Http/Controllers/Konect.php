<?php

//con este metodo generamos la conexion con la base de datos con el usuario keySystem el cual solo tiene permiso de SELECT y EXECUTE en los precedimientos
//para agregar la configuracion se utilizan las variables en el archivo .env de la aplicación en la sección de base de datos
function conectar(){
    $username = config('database.connections.mysql.username');
    $password = config('database.connections.mysql.password');
    $dataBase = config('database.connections.mysql.database');
    $host = config('database.connections.mysql.host');
    
    $cs = "mysql:host={$host};dbname={$dataBase};charset=utf8";
    try{
        $conection = new PDO($cs,$username,$password);
        return $conection;
    }catch(PDOException $e){
        return $e->getMessage();
    }
}