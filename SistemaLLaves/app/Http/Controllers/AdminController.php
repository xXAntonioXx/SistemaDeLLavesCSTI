<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Filesystem\Filesystem;

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
            'rol'=>'required'
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

    public function actualizarHorarios(){
        return view('actualizarHorarios');
    }

    public function procesarArchivoHorarios(Request $req){
        $nombreArchivo = $req->file('Horario_llaves')->storeAs('horarios','NuevoHorario.csv');
        $rutaAbsoluta = storage_path() . '/app/' . $nombreArchivo;

        $ciclo = $req['ciclo'];
        $diasSemana = array(
            0 => "LUNES",
            1 => "MARTES",
            2 => "MIERCOLES",
            3 => "JUEVES",
            4 => "VIERNES",
            5 => "SABADO",
        );

        $lineas = 0;
        $archivoGuardado = fopen($rutaAbsoluta,'r');
        while(($renglonHorario = fgetcsv($archivoGuardado,2000,',')) !== FALSE){
            $numEmp = $renglonHorario[0];
            $nombreMaestro = $renglonHorario[1];
            $nombreMateria = $renglonHorario[2];
            $llave = $renglonHorario[4];
            $programa = $renglonHorario[5];
            $diasAux = "";
            $year = date("Y");
            $hora = [];
            for($i = 0;$i < 6; $i++){
                if($renglonHorario[6 + $i] != ""){
                    $diasAux = $diasAux.$diasSemana[$i].",";
                }
                if($renglonHorario[6 + $i] != "" && count($hora) == 0){
                    $hora = explode("-",$renglonHorario[6 + $i]);
                }
            }
            $dias = substr($diasAux,0,-1);
            $lineas++;  

            $consulta = "CALL sp_registrar_horario({$numEmp},'{$nombreMaestro}','{$nombreMateria}',{$llave},'{$programa}','{$dias}','{$hora[0]}','{$hora[1]}','{$year}','{$ciclo}')";
            $this->conexion->query($consulta);
        }
        
        return view('actualizarHorarios');
    }

    public function descargarEjemplo(){
        $headers = array(
            'Content-Type: text/csv',
          );
        $ejemplo = public_path()."/archivos/HorariosEjemplo.csv";
        return response()->download($ejemplo,"HorariosEjemplo.csv",$headers);
    }
}
