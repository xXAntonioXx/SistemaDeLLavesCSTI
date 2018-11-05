<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\MessageBag;
use Session;
include 'konect.php';

class LoginController extends Controller
{
    public $conexion;

    //constructor necesario para hacer la conexion con la base de datos
    public function __construct(){
        $this->conexion=conectar();
    }

    //devuelve la vista principal para el login
    public  function principal(){
        return view('login');
    }

    //borrar metodo de abajo
    public function insertar(){
        try{
            //$conexion = conectar();
            //dd($conexion);
            $contraseña=password_hash("contra",PASSWORD_DEFAULT);

            $insert="INSERT INTO tusuarios(id,nombre,contrasena,rol,estado) values(2,'antonio2','{$contraseña}','1',0)";
            //dd($insert);
            $this->conexion->query($insert);
        }catch(PDOException $e){
            return "error";
        }
        
    }

    //confirmacion de credenciales
    public function validar(Request $req){
        $this->validate($req,[
            'nombre'=>'required',
            'contra'=>'required'
        ]);

        $nombreUsuario=$req['nombre'];
        $contra=$req['contra'];

        $datos = $this->conexion->query("SELECT * FROM tusuarios WHERE nombre='{$nombreUsuario}'")->fetch();
        //aqui puedes checar si es la primera vez que se logean:
        if(/*$datos['estado']==0 &&*/ !$datos){
            return 'este usuario se logeara por primera vez';
        }else{
            $RESULTADO = password_verify($contra,$datos['contrasena']);
            if($RESULTADO){
                //session_start();
                Session::put('estado',true);
                //$_SESSION['nombre']=true;
                return redirect('/main');
            }else{
                $cerror=['cerror'=>'wrong'];
                return redirect('/')->withErrors($cerror);
            }
        }
        return redirect('/');
    }

    public function salir(){
        Session::forget('estado');
    }
}
