<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

include 'Konect.php';

class BusquedaController extends Controller
{
    public $conexion;//instanciamos la conexión a la base de datos

    public function __construct(){
        if(!$this->conexion){
            $this->conexion=conectar();//abrimos la conexión a la base de datos
        }
    }

    public function cargarBusqueda(){

        $cadenaConsulta = "CALL sp_get_busqueda(null,null,null,null,null,null)";
        $registros=$this->conexion->query($cadenaConsulta)->fetchAll();
        if($registros){
            //return view('busqueda')->with(['respuesta'=>json_encode($registros)]);
            return view('busqueda')->with('respuesta',json_encode($registros));
        }else{
            return view('busqueda');
        }
    }

    public function CargarRegistro(Request $req){
        $fechaInferior = $req['fechaMinima']?$req['fechaMinima']:'2019-01-01';
        $fechaSuperior = $req['fechaMaxima']?$req['fechaMaxima']:date('Y-m-d');

        $timeMinimo = "'{$fechaInferior} {$req['horaMinima']}".":00'";
        $timeMaximo = "'{$fechaSuperior} {$req['horaMaxima']}".":00'";

        $maestro = $req['Maestro'] ? "'".strtoupper($req['Maestro'])."'" : "NULL";
        $materia = $req['Materia']?"'".strtoupper($req['Materia'])."'":"NULL";

        $ValidarSalon=strlen($req['Aula']);
        $area="NULL";
        $aula="NULL";
        
        switch($ValidarSalon){
            case 6:
                if(preg_match("/^5.*[kjgomKJGOM]{1}.*[-]{1}.*\d{3}/",$req['Aula'])){
                    $area = "'".mb_substr($req['Aula'],0,2)."'";
                    $aula = "'".mb_substr($req['Aula'],3,null)."'";
                }
                break;
            case 2:
                if(preg_match("/^5.*[kjgomKJGOM]{1}/",$req['Aula'])){
                    $area = "'".$req['Aula']."'";
                }
                break;
            case 3:
                if(preg_match("/\d{3}/",$req['Aula'])){
                    $aula = "'".$req['Aula']."'";
                }
                break;
        }

        $cadenaConsulta = "CALL sp_get_busqueda({$timeMinimo},{$timeMaximo},{$maestro},{$materia},{$area},{$aula})";
        $registros=$this->conexion->query($cadenaConsulta)->fetchAll();
        if($registros){

            //return view('busqueda')->with('respuesta',json_encode($registros));
            return view('busqueda')->with('respuesta',env('APP_NAME'));

        }else{

            return view('busqueda')->withErrors(['respuesta'=>'No se encontraron registros']);

        }

    }
}
