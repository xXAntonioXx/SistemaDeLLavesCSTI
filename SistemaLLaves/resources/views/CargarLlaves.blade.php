@extends('layouts.navFoot')
@section('cuerpo')
<div class="primary-content">
  
  <div class="section-title">
    <h2>Registrar Llaves</h2>
  </div>
  <section class="center-content">
    <form class="newUserForm" method="POST" action="/AgregarLlavescsv" enctype="multipart/form-data">
        {{csrf_field()}}
        <input type="file" name="archivo_fls"/><br>
        <input class="submitBtn" type="submit" name="enviar" value="Cargar Archivo"/>
    </form>
  </section>
</div>
@stop