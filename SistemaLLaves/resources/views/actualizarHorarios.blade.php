@extends('layouts.navFoot')
@section('cuerpo')
    <div style="text-align:center">
        <form action="procesarArchivoHorarios" method="POST" enctype="multipart/form-data">
            <label>Seleccione un archivo</label><br/>
            <input type="file" id="Horario_llaves" name="Horario_llaves" /><br/>
            <input type="radio" name="ciclo" value="1"/>1<br/>
            <input type="radio" name="ciclo" value="2"/>2<br/>
            <input type="submit" id="mandar"/>
        {{csrf_field()}}
        </form>
    </div>
@stop