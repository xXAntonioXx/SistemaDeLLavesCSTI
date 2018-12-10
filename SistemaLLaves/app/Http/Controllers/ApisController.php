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

    public function nuevoPrestamo(Request $req){
        $id=$req["id"];
        $objetos=$req["objList"];
        
        $prestamo="CALL sp_registrar_prestamo({$id},{$objetos})";
        $this->conexion->query($prestamo);
    }

    public function Borrame(Request $req){
        dd($req->session()->get('id'));
    }

    public function nuevoRegistro(Request $req){
        $registrar="CALL sp_registrar_registro('2018-12-10 00:00:00',7,1)";
        $this->conexion->query($registrar);
    }

}
