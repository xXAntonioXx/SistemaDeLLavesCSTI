@extends('layouts.navFoot')
@section('cuerpo')
    <div class="cebolla">

        <div style="text-align:center;width: 100%;">
                <h1>Bienvenido administrador</h1>
        </div>
        <div class="contenedor">
            <div onclick="location.href='/panel/nuevoUsuario';">
                <h2>Administrar Usuarios</h2>
                <p>Agregar nuevos Usuarios o gestionar los que ya existen</p>
           </div>
            <div>
                <h2>Cargar un Nuevo Horario</h2>
                <p>Cambiar el horario de las clases en la base de datos a partir de un archivo CSV</p>
            </div>
            <div>
                <h2>Cargar llaves de las Aulas</h2>
                <p>Apartir de un archivo de csv se pueden cargar las llaves de las aulas</p>
            </div>
        </div>
    </div>
@stop