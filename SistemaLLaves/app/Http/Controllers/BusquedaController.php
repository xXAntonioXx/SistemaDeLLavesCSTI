<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
/*****************************************************************************************************************************************************************************
 * Esta controlador se encarga de hacer trabajar el apartado de busqueda que es donde aparecen todos los registros hechos desde el principio del ciclo, todos los metodos
 * consultados aquí se encargan del apartado mencionado a excepción de donde se muestran los objetos que van asociados a cada registro eso se encuentra en ApisController.php
 * 
 */
include 'Konect.php';

class BusquedaController extends Controller
{
    public $conexion;//instanciamos la conexión a la base de datos

    public function __construct(){
        if(!$this->conexion){
            $this->conexion=conectar();//abrimos la conexión a la base de datos
        }
    }

    public function cargarBusqueda(){//aquí cargamos la vista principal de todos los registros realizados, eso implica solicitar todos los registros existentes en la base de datos

        $cadenaConsulta = "CALL sp_get_busqueda(null,null,null,null,null,null)";//llamada al procedimiento
        $registros=$this->conexion->query($cadenaConsulta)->fetchAll();//registros solicitados de la base de datos
        if($registros){//si se encuentran registros en la base de datos(está la posibilidad de que no se encuentren registros)
            return view('busqueda')->with('respuesta',json_encode($registros));//se devuelve la vista junto con los registros
        }else{
            return view('busqueda');//se devuelve la vista pero sin registros
        }
    }

    public function CargarRegistro(Request $req){//metodo para el filtro de busqueda

        $fechaInferior = $req['fechaMinima']?$req['fechaMinima']:'2019-01-01';//fecha mínima en el intervalo de tiempo que se desea buscar
        $fechaSuperior = $req['fechaMaxima']?$req['fechaMaxima']:date('Y-m-d');//fecha superior en el intervalo de tiempo que se desea buscar

        $timeMinimo = "'{$fechaInferior} {$req['horaMinima']}".":00'";//Hora mínima en el intervalo de tiempo(horas del día) de las que se quiere filtrar
        $timeMaximo = "'{$fechaSuperior} {$req['horaMaxima']}".":00'";//Hora maxima en el intervalo de tiempo(horas del día) de las que se quiere filtrar

        $maestro = $req['Maestro'] ? "'".strtoupper($req['Maestro'])."'" : "NULL";//nombre del maestro que se desea buscar(puede contener desde un solo nombre hasta el nombre completo)
        $materia = $req['Materia']?"'".strtoupper($req['Materia'])."'":"NULL";//Clase que se desea buscar(puede contener desde un solo nombre hasta el nombre completo)

        $FiltroSalon=preg_replace('/\s+/', '', $req['Aula']);

        $ValidarSalon=strlen($FiltroSalon);//Aula de la llave que se desea buscar, se permite de tres maneras. Con el edificio(ejem: 5G), con el numero de aula(ejem: 201) o el nombre completo(ejem: 5G-201)
        $area="NULL";//El procedmiento requiere que se divida el nombre de aula en dos, el area(edificio)
        $aula="NULL";//El procedmiento requiere que se divida el nombre de aula en dos, el aula(salón dentro del edificio

        switch($ValidarSalon){//dependiendo de la longitud en el input de busqueda se toman tres casos diferentes
            case 6://en caso de buscar especificamente(edificio-aula)
                if(preg_match("/^[58].*[kjgomKJGOM]{1}.*[-]{1}.*\d{3}/",$FiltroSalon)){
                    $area = "'".mb_substr($FiltroSalon,0,2)."'";
                    $aula = "'".mb_substr($FiltroSalon,3,null)."'";
                }
                break;
            case 2://en caso de buscar solamente el edificio
                if(preg_match("/^[58].*[kjgomKJGOM]{1}/",$FiltroSalon)){
                    $area = "'".$FiltroSalon."'";
                }
                break;
            case 3://en caso de buscar solamente el aula
                if(preg_match("/\d{3}/",$FiltroSalon)){
                    $aula = "'".$FiltroSalon."'";
                }
                break;
        }

        $cadenaConsulta = "CALL sp_get_busqueda({$timeMinimo},{$timeMaximo},{$maestro},{$materia},{$area},{$aula})";//se lleva a cabo la busqueda de los registros(podria ser solo un registro o podrian ser varios)
        $registros=$this->conexion->query($cadenaConsulta)->fetchAll();
        if($registros){//en caso de que tengamos una coincidencia en la busqueda

<<<<<<< HEAD
            return view('busqueda')->with('respuesta',json_encode($registros));
            //return view('busqueda')->with('respuesta',env('APP_NAME'));
=======
            return view('busqueda')->with('respuesta',json_encode($registros));//se regresa la vista junto con los registros encontrados
>>>>>>> 34d5d38fb1cd67bf6aaa89849382873d8906e7f0

        }else{

            return view('busqueda')->withErrors(['respuesta'=>"No se encontraron registros"]);//en caso de no encontrarse coincidencias se devuelve la vista con un mensaje.

        }

    }
}
