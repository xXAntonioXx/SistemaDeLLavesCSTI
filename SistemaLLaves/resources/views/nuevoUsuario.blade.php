@extends('layouts.navFoot')
@section('cuerpo')
    <form action="/AgregarUsuario" class="newUserForm" method="POST">
        {{csrf_field()}}
        <label for="NewUserName">Nombre del Usuario:</label>
        <input id="NewUserName" name="NewUserName" type="text" placeholder="Cualquier nombre funciona">
        <br>
        <select name="rol" id="rol">
            <option>Permisos...</option>
            <option value="1">Admin</option>
            <option value="2">Secretari@</option>
        </select>
        <br>
        <label for="NewUserPass">Contraseña:</label>
        <input id="NewUserPass" name="NewUserPass" type="password" placeholder="Cualquier contraseña funciona">
        <br>
        <label for="confirmPass">Confirmar Contraseña</label>
        <input id="confirmPass" name="confirmPass" type="password" placeholder="Volver a escribir contraseña">
        <br>
        <input type="submit" value="Agregar">
    </form>
@stop