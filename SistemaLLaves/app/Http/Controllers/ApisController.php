<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

include 'Konect.php';

class ApisController extends Controller
{
    public $conexion;

    public function __construct(){
        $this->conexion=conectar();
    }

    public function registrosNum(Request $req){

        //Trae todos los registros del dia de hoy

        $registros=$this->conexion->query('CALL sp_get_llavesPrestadas()')->fetchAll();
        $coleccion=collect($registros);

        return $coleccion;
        
    }

    public function buscarHorario($codigo,$hora){
        $consulta="CALL sp_get_frmPrestamo({$codigo},'{$hora}')";
        $horario=$this->conexion->query($consulta)->fetch();
        if($horario){
            return $horario;    
        }
        return $horario;
    }

}
