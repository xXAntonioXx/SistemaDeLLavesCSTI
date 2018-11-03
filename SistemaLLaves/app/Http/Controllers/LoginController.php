<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\MessageBag;
include 'konect.php';

class LoginController extends Controller
{
    public $conexion;

    public function __construct(){
        $this->conexion=conectar();
    }

    public  function principal(){
        return view('login');
    }

    public function borrame(){
        //return \PDO::getAvailableDrivers();
        /*$conexion = conectar();
        $datos = $conexion->query("select * from tusuarios")->fetch();
        
        return $datos['contrasena'];*/
    }

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
                session_start();
                $_SESSION['nombre']=true;
                return redirect('/main');
            }else{
                $cerror=['cerror'=>'wrong'];
                return redirect('/')->withErrors($cerror);
            }
        }
        //return ($RESULTADO?'igual':'diferente');
        return redirect('/');
    }
}
