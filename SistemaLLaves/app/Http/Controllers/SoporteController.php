<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

include 'Konect.php';

class SoporteController extends Controller
{
    public $conexion;//instanciamos la conexión a la base de datos

    public function __construct(){
        if(!$this->conexion){
            $this->conexion=conectar();//abrimos la conexión a la base de datos
        }
    }

    public function EnviarMail(Request $req){
        //mail("jose_antony11@hotmail.com","esta es una prueba","si lees esto antonio significa que se esta logrando enviar un correo");
        return view('principal');
    }
}
