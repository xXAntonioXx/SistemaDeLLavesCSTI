<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

include 'Konect.php';

class InventarioController extends Controller
{
    public $conexion;//instanciamos la conexión a la base de datos

    public function __construct(){
        if(!$this->conexion){
            $this->conexion=conectar();//abrimos la conexión a la base de datos
        }
    }

    public function cargarInventario(){//Llamada a la vista del inventario
        $query="CALL sp_get_objetos(null)";
        $objetosEnDisponibles = $this->conexion->query($query)->fetchAll();
        return view('inventario');
    }

    public function TraerTodosLosObjetos(){
        $query="CALL sp_get_objetos(null)";
        $objetosEnDisponibles = $this->conexion->query($query)->fetchAll();
    }
}
