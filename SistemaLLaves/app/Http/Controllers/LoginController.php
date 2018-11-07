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
            
            $contraseña=password_hash("contra",PASSWORD_DEFAULT);

            $insert="INSERT INTO tusuarios(id,nombre,contrasena,rol,estado) values(1,'antonio','{$contraseña}','1',0)";
            
            $this->conexion->query($insert);
        }catch(PDOException $e){
            return "error";
        }
        
    }

    //confirmacion de credenciales
    public function validar(Request $req){//validamos si el post no viene vacio
        
        $this->validate($req,[
            'nombre'=>'required',
            'contra'=>'required'
        ]);

        $nombreUsuario=$req['nombre'];
        $contra=$req['contra'];

        $datos = $this->conexion->query("SELECT * FROM tusuarios WHERE nombre='{$nombreUsuario}'")->fetch();
        if($datos['estado']==1 && $datos){//para el caso de que el usuario exista y este habil
            
            $RESULTADO = password_verify($contra,$datos['contrasena']);//comprobamos si la contraseña esta correcta
            
            if($RESULTADO){
                
                Session::put('estado',true);
                return redirect('/main');
            
            }else{
                
                $cerror=['cerror'=>'usuario/contraseña incorrecta'];
                return redirect('/')->withErrors($cerror);
            }
        
        }else if($datos['estado']==0 && $datos){//en caso de que el usuario este inhabil
                
            $cerror=['cerror'=>'usuario inhábil'];
            return redirect('/')->withErrors($cerror);
        
        }else{//en caso de que el usuario este equivocado(por seguridad se muestra el mismo error que el de contraseña incorrecta)
            
            $cerror=['cerror'=>'usuario/contraseña incorrecta'];
            return redirect('/')->withErrors($cerror);
        
        }
    }

    public function salir(){
        Session::forget('estado');
        return redirect('/');
    }
}
