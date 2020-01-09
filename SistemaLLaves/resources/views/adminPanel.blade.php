@extends('layouts.navFoot')
@section('cuerpo')
    <div class="cebolla">

        <div style="text-align:center;width: 100%;">
                <h1>Bienvenido administrador</h1>
        </div>
        <div class="contenedor">
            <div class="tarjeta" onclick="location.href='/panel/nuevoUsuario';">
                <div  class="encabezado-tarjeta">
                    <h2>Administrar Usuarios</h2>
                </div>
                <div class="cuerpo-tarjeta">
                    <p>En esta sección usted puede agregar nuevos usuarios o gestionar los ya existentes.</p>
                </div>
           </div>
            <div class="tarjeta" onclick="location.href='/panel/actualizarHorarios';">
                <div  class="encabezado-tarjeta">
                    <h2>Cargar un Nuevo Horario</h2>
                </div>
                <div class="cuerpo-tarjeta">
                    <p>Cambiar el horario de las clases en la base de datos a partir de un archivo CSV</p>
                </div>
            </div>
            <div class="tarjeta" onclick="location.href='/panel/cargarHorarios';">
                <div  class="encabezado-tarjeta">
                    <h2>Cargar Horarios</h2>
                </div>
                <div class="cuerpo-tarjeta">
                    <p>En esta sección usted puede cargar horarios de clases desde un archivo CSV.</p>
                </div>
            </div>
            <div class="tarjeta" onclick="location.href='/panel/cargarLlaves';">
                <div class="encabezado-tarjeta">
                    <h2>Registro de llaves</h2>
                </div>
                <div class="cuerpo-tarjeta">
                    <p>En esta sección usted puede agregar llaves de manera manual o puede cargar multiples registros desde un archivo CSV.</p>
                </div>
            </div> -->
        </div>
    </div>
@stop