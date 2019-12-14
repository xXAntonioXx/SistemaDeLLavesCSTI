<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

include 'Konect.php';
class AdminController extends Controller
{
    public $conexion;

    //constructor necesario para hacer la conexion con la base de datos
    public function __construct(){
        $this->conexion=conectar();
    }

    public function Cargar(){
        return view('adminPanel');
    }

    public function NuevoUsuario(){
        return view('nuevoUsuario');
    }
    public function RegistrarUsuario(Request $req){

        $this->validate($req,[
            'NewUserName'=>'required',
            'NewUserPass'=>'required',
            'confirmPass'=>'required',
            'rol'=>'required|integer'
        ]);

        $nombre = $req['NewUserName'];
        $contraseña = $req['NewUserPass'];
        $confirmContraseña = $req['confirmPass'];
        $rol = $req['rol'];
        if($contraseña == $confirmContraseña){
            $PASS=password_hash($contraseña,PASSWORD_DEFAULT);
            $consulta = "INSERT INTO tusuarios(nombre,contrasena,rol) VALUES('{$nombre}','{$PASS}',{$rol})";
            $this->conexion->query($consulta);
        }
        return view('nuevoUsuario');
    }
}
