<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

//con este controlador manejaremos las opciones disponibles en el nav
class PrincipalController extends Controller
{
    public function cargarRegistro(){
        return view('principal');
    }

    public function cargarInventario(){
        return view('inventario');
    }
}
