<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

include 'Konect.php';

class ApisController extends Controller
{
    public $conexion;//instanciamos la conexión a la base de datos

    public function __construct(){
        $this->conexion=conectar();//abrimos la conexión a la base de datos
    }

    public function registrosNum(Request $req){//devuelve los registros del dia actual de la base de datos

        $registros=$this->conexion->query('CALL sp_get_llavesPrestadas()')->fetchAll();
        $coleccion=collect($registros);//tomamos todos los JSON devueltos y los colocamos en uno solo(buscar:laravel colecciones)

        return $coleccion;
        
    }

    public function buscarHorario($codigo,$hora){//buscamos el horario en base al codigo de la llave y la hora
        $consulta="CALL sp_get_frmPrestamo({$codigo},'{$hora}')";
        $horario=$this->conexion->query($consulta);
        if($horario){//solo en caso de que exista el horario se retornara en forma de JSON
            return $horario->fetch();    
        }
        return $horario;//de lo contrario se devuelve un false
    }

    public function nuevoPrestamo(Request $req){//generamos un nuevo prestamo de objetos(controles A/AC, control cañon, bocinas)
        $id=$req["id"];
        $objetos=$req["objList"];
        
        $prestamo="CALL sp_registrar_prestamo({$id},{$objetos})";
        $this->conexion->query($prestamo);
    }

    public function nuevoRegistro(Request $req){//ya generado un prestamo generamos un registro de de que la llave de cierto salon fue tomado a determinada hora por determinado maestro segun el horario
        $hora=$req["fechaHora"];
        $idHorario=$req["idHorario"];
        $idUsuario=$req->session()->get('id');//obtenemos el identificador de la sercretaria/usuario que registro la llave
        $registrar="CALL sp_registrar_registro('{$hora}',{$idHorario},{$idUsuario})";
        $this->conexion->query($registrar);
    }

}
