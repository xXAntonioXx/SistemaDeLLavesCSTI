@extends('layouts.navFoot')
@section('cuerpo')
<div class="twoColBody">
    <section class="left-content">
      <div class="section-title">
        <h2>Registro de Llaves</h2>
      </div>
        <form action="/AgregarUsuario" class="newUserForm" method="POST">
            {{csrf_field()}}
            <strong>Código de llave</strong> <br>
            <input class="inp" id="newcodigo" name="newcodigo" type="text" placeholder=" ej. 64477287912">
            <br>
            <strong>Numero de aula</strong><br>
            <input class="inp" id="newnumaula" name="newnumaula" type="text" placeholder=" ej. 23">
            <br>
            <strong>Área</strong><br>
            <input class="inp" id="newarea" name="newarea" type="text" placeholder=" ej. 5G">
            <br>
            <strong>Aula</strong><br>
            <input class="inp" id="newaula" name="newaula" type="text" placeholder=" ej. 204">
            <br>
            <input class="submitBtn" type="submit" value="Agregar">
        </form>
        @if($errors->has('NewUserName') || $errors->has('NewUserPass') || $errors->has('confirmPass'))
            <div class="tooltip-container">
                <span class="tooltip-text">Faltan datos</span>
            </div>
        @endif
    </section>

    <section class="right-content">
        <div id="app">
            <llaves></llaves>
        </div>
    </section>
</div>
<script src="{{asset('js/app.js')}}"></script>
@stop
