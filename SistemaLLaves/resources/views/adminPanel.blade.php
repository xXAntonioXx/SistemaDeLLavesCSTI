@extends('layouts.navFoot')
@section('cuerpo')
    <div class="cebolla">

        <div style="text-align:center;width: 100%;">
                <h1>Bienvenido administrador</h1>
        </div>
        <div class="contenedor">
            <div class="tarjeta" onclick="location.href='/panel/nuevoUsuario';">
                <div class="encabezado-tarjeta">
                    <h2>Administrar Usuarios</h2>
                </div>
                <div class="cuerpo-tarjeta">
                    <p>Agregar nuevos Usuarios o gestionar los que ya existen</p>
                </div>
            </div>
            <div class="tarjeta" onclick="location.href='/panel/cargarHorarios';">
                <div  class="encabezado-tarjeta">
                    <h2>Cargar un Nuevo Horario</h2>
                </div>
                <div class="cuerpo-tarjeta">
                    <p>Cambiar el horario de las clases en la base de datos a partir de un archivo CSV</p>
                </div>
            </div>
            <div class="tarjeta">
                <div class="encabezado-tarjeta">
                    <h2>Cargar llaves de las Aulas</h2>
                </div>
                <div class="cuerpo-tarjeta">
                    <p>Apartir de un archivo de csv se pueden cargar las llaves de las aulas</p>
                </div>
            </div>
        </div>
    </div>
@stop