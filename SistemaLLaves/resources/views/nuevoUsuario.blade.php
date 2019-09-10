@extends('layouts.navFoot')
@section('cuerpo')
<div class="twoColBody">
    <section style="text-align:center;">
        <form action="/AgregarUsuario" class="newUserForm" method="POST">
            {{csrf_field()}}
            <strong>Nombre del Usuario</strong> <br>
            <input class="inp" id="NewUserName" name="NewUserName" type="text" placeholder=" Cualquier nombre funciona">
            <br>
            <strong>Contraseña</strong><br>
            <input class="inp" id="NewUserPass" name="NewUserPass" type="password" placeholder=" Cualquier contraseña funciona">
            <br>
            <strong> Confirmar Contraseña</strong><br>
            <input class="inp" id="confirmPass" name="confirmPass" type="password" placeholder=" Volver a escribir contraseña">
            <br>
            <select name="rol" id="rol" class="dropdown">
                <option>Permisos...</option>
                <option value="1">Admin</option>
                <option value="2">Secretari@</option>
            </select>
            <br>
            <input class="submitBtn" type="submit" value="Agregar">
        </form>
        @if($errors->has('NewUserName') || $errors->has('NewUserPass') || $errors->has('confirmPass'))
            <div class="tooltip-container">
              <span class="tooltip-text">Faltan datos</span>
            </div>
          @endif
    </section>

    <section>
        <div id="app" style="height:100%">
            <usuarios></usuarios>
        </div>
    </section>
</div>
<script src="{{asset('js/app.js')}}"></script>
@stop