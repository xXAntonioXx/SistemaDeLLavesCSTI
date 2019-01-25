<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
include 'Konect.php';
//con este controlador manejaremos las opciones disponibles en el nav
class PrincipalController extends Controller
{
    public function cargarRegistro(){
        return view('principal');
    }

    public function actualizarEstadoRegistros(){//este metodo es para identificar que registros ya pasaron de su correspondiente hora de devolución
        $conexion=conectar();
        $todosLosRegistros=$conexion->query('CALL sp_get_llavesPrestadas()')->fetchAll();
        $idNoDevueltos = map($this->paraHacerMap,$todosLosRegistros);
        return view('principal')
    }

    private function paraHacerMap($registro){
        //if ($registro['hora_entrada'])
    }

    public function cargarInventario(){//una vez creado la vista para el inventario quita este metodo de aqui y muevelo a su correspondiente controlador
        return view('inventario');
    }
}
