<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Portal de Llaves</title>
  <link rel="icon" type="image/png" href="{{asset('/images/key.ico')}}">
  <link rel="stylesheet" href="{{asset('/css/inicio-sesion.css')}}">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
</head>
<body>
  <div class="container">
    <form action="/validate" method ="post" class="inicio-sesion">
      {{csrf_field()}}
      <h1>Iniciar Sesión</h1>
      <h2>Usuario</h2>
      <input type="text" placeholder="Ingresa tu suario" name="nombre">
      <h2>Contraseña</h2>
      <input type="password" placeholder="Ingresa tu contraseña" name="contra">
      @if($errors->has('nombre') || $errors->has('contra'))
        <div class="tooltip-container">
          <span class="tooltip-text">Usuario y/o Contraseña Requeridas</span>
        </div>
      @endif
      @if($errors->has('cerror'))
        <div class="tooltip-container">
          <span class="tooltip-text">{{$errors->first()}}</span>
        </div>
        <!--p>{{$errors->first()}}</p-->
      @endif
      <a href="">¿Olvidó su contraseña?</a>
      <input type="submit" class="ingresar" style="display:none;">
      <input type="submit" value="Ingresar" class="ingresar"/>
      <img src="{{asset('/images/logo-77aniversario.png')}}" width="80px" alt="Logo Aniversario Unison">
    </form>
    

  </div>
</body>
</html>