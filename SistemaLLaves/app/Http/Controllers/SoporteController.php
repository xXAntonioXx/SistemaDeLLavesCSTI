<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Mail\PruebaMail;
use Mail;

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
        $data=['mensaje'=>'this is a test exito'];
        Mail::to('rocker4NT0N10@gmail.com')->send(new PruebaMail($data));
        return view('principal');
    }
}
