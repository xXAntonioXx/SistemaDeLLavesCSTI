<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\MessageBag;
use Session;
/**
 * En esta clase se se devulven la vista de login y se manejan las validadciones necesarias para los usuarios
 */


include 'Konect.php';

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

    //confirmacion de credenciales
    public function validar(Request $req){//validamos si el post no viene vacio

        $this->validate($req,[
            'nombre'=>'required',
            'contra'=>'required'
        ]);

        $nombreUsuario=$req['nombre'];
        $contra=$req['contra'];

        $datos = $this->conexion->query("SELECT * FROM tusuarios WHERE nombre='{$nombreUsuario}'")->fetch();
        //dd($this->conexion);
        //$datos = $this->conexion->query("SELECT * FROM tusuarios WHERE nombre='{$nombreUsuario}'");
        if($datos['estado']==1 && $datos){//para el caso de que el usuario exista y este habil
            
            $RESULTADO = password_verify($contra,$datos['contrasena']);//comprobamos si la contraseña esta correcta
            
            if($RESULTADO){
                
                Session::put('estado',true);
                Session::put('id',$datos['id']);
                Session::put('rol',$datos['rol']);
                return redirect('/main');
            
            }else{
                
                $cerror=['cerror'=>'usuario/contraseña incorrecta'];
                return redirect('/')->withErrors($cerror);
            }
        
        }else if($datos['estado']==0 && $datos){//en caso de que el usuario este inhabil
            
            $cerror=['cerror'=>'usuario inhábil'];
            //dd($cerror);
            return redirect('/')->withErrors($cerror);
        
        }else{//en caso de que el usuario este equivocado(por seguridad se muestra el mismo error que el de contraseña incorrecta)
            
            $cerror=['cerror'=>'usuario/contraseña incorrecta'];
            return redirect('/')->withErrors($cerror);
        
        }
    }

    public function salir(){//eliminamos la variables de cookie para matar la sesion y redirijimos al login
        Session::forget('estado');
        Session::forget('id');
        Session::forget('rol');
        return redirect('/');
    }
}
