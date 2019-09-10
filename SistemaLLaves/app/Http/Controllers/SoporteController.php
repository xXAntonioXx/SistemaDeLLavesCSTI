<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Mail\PruebaMail;
use Mail;
/**
 * En esta clase hacemos llegar un mensaje del usuario a la oficina de soporte por medio de un correo dirijido(temporalmente al encargado de desarrollo)
 */
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
        $req->validate([
            'asunto'=>'required',
            'description'=>'required'
        ]);

        $data=['mensaje'=>$req['description'],'subject'=>$req['asunto']];
        Mail::to('rocker4NT0N10@gmail.com')->send(new PruebaMail($data));
        return view('principal');

    }
}
