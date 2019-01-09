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
        $timeMinimo = "'{$req['fechaMinima']} {$req['horaMinima']}".":00'";
        $timeMaximo = "'{$req['fechaMaxima']} {$req['horaMaxima']}".":00'";

        $maestro = $req['Maestro'] ? "'{$req['Maestro']}'" : "NULL";
        $materia = $req['Materia']?"'{$req['Materia']}'":"NULL";

        $area="NULL";
        $aula="NULL";
        if(preg_match("/^5.*[kjgomKJGOM]{1}.*[-]{1}.*\d{3}/",$req['Aula'])){
            $area = "'".mb_substr($req['Aula'],0,2)."'";
            $aula = "'".mb_substr($req['Aula'],3,null)."'";
        }

        $cadenaConsulta = "CALL sp_get_busqueda({$timeMinimo},{$timeMaximo},{$maestro},{$materia},{$area},{$aula})";
        $registros=$this->conexion->query($cadenaConsulta)->fetchAll();
        if($registros){
            return view('busqueda')->with('respuesta',json_encode($registros));
            //return view('busqueda')->with('respuesta','respuesta');
        }else{
            return view('busqueda')->with('respuesta',$cadenaConsulta);
        }
        //return view('busqueda')->with('respuesta',$cadenaConsulta);

    }
}
