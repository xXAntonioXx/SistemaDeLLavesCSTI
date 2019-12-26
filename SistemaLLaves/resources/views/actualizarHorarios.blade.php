@extends('layouts.navFoot')
@section('cuerpo')
    <div style="text-align:center">
        <form action="procesarArchivoHorarios" method="POST" enctype="multipart/form-data" style="font-size:0.7em;text-align:left;margin-left:25px;">
            <p >para actualizar el horario en el cual las aulas se estarán ocupando se requiere un archivo de excel csv <a href="/public/archivos/Horarios-Enero-2018.csv">ejemplo</a><br/>
            NOTA:ya deben estar cargadas las llaves</p><br/><br/>
            <label>Seleccione un archivo:</label>
            <input type="file" id="Horario_llaves" name="Horario_llaves" /><br/>
            <label>Seleccione el ciclo escolar: </label>
            <input type="radio" name="ciclo" value="1"/>Enero a Mayo
            <input type="radio" name="ciclo" value="2"/>Agosto a Noviembre<br/>
            <input type="submit" id="mandar" value="registrar horario" />
        {{csrf_field()}}
        </form>
    </div>
@stop