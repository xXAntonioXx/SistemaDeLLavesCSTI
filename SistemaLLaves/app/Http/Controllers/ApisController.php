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
        $horario=$this->conexion->query($consulta);
        if($horario){
            return $horario->fetch();    
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
        $hora=$req["fechaHora"];
        $idHorario=$req["idHorario"];
        $idUsuario=$req->session()->get('id');
        $registrar="CALL sp_registrar_registro('{$hora}',{$idHorario},{$idUsuario})";
        $this->conexion->query($registrar);
    }

}
