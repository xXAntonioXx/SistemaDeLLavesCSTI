<?php
//DATOS DEL USUARIO:
$user='admin';
$password='contra';


function registrar($a,$b){
        try {
            $conexion = new PDO('mysql:host=localhost;dbname=sistema_llaves','root','Kgmt1709');
            $contra=password_hash($b, PASSWORD_DEFAULT);
            $statement = $conexion->query("INSERT INTO tusuarios VALUES(null,'$a','$contra',1,DEFAULT)");
            
        } catch (PDOException $e) {
            echo "error: " . $e->getMessage();
        }
    }

registrar($user,$password);
	
?>