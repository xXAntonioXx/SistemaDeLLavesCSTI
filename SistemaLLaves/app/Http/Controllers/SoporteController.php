<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Mail\PruebaMail;
use Mail;
/**
 * En esta clase hacemos llegar un mensaje del usuario a la oficina de soporte por medio de un correo dirijido(temporalmente al encargado de desarrollo)
 */
include 'Konect.php';

class SoporteController extends Controller
{
    public $conexion;//instanciamos la conexión a la base de datos

    public function __construct(){
        if(!$this->conexion){
            $this->conexion=conectar();//abrimos la conexión a la base de datos
        }
    }

    public function EnviarMail(Request $req){
        $req->validate([
            'asunto'=>'required',
            'description'=>'required'
        ]);

        $data=['mensaje'=>$req['description'],'subject'=>$req['asunto']];
        Mail::to('rocker4NT0N10@gmail.com')->send(new PruebaMail($data));
        return view('principal');

    }

    public function home(){
        return view('soporte');
    }


    public function getAulas(){
        $query="CALL sp_obtener_llaves_para_reportes()";
        $aulas= $this->conexion->query($query)->fetchAll();
        return $aulas;
    }

    public function getReportes(){
        $query="CALL sp_obtener_reportes_para_soporte()";
        $reportes= $this->conexion->query($query)->fetchAll();
        return $reportes;
    }

    public function registrarReporte(Request $req){
        $this->validate($req,[
            'aula'=>'required',
            'descripcion'=>'required'
        ]);

        $aula=$req['aula'];
        $descripcion=$req['descripcion'];
        $consulta= "CALL sp_registrar_reporte('$descripcion',$aula)";
        $stmt=$this->conexion->query($consulta);
        if (!$stmt) {
            return response()->json(['message'=> $this->conexion->errorInfo()],400);
        }
        return response()->json(['message'=> 'El reporte se registro con éxito.'],200);

    }
}
