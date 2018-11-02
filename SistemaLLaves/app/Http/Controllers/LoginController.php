<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
include 'konect.php';

class LoginController extends Controller
{

    public function borrame(){
        //return \PDO::getAvailableDrivers();
        $conexion = hola();
        $datos = $conexion->query("select * from tusuarios")->fetch();
        return $datos['contrasena'];
    }

    public function validar(Request $req){
        return 
    }
}
