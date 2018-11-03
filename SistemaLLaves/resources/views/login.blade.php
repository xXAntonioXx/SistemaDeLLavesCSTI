<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Portal de Llaves</title>
  <link rel="icon" type="image/png" href="images/key.png">
  <link rel="stylesheet" href="{{asset('/css/inicio-sesion.css')}}">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
</head>
<body>
  <div class="container">
    <form action="/validate" method ="post" class="inicio-sesion">
      {{csrf_field()}}
      <h1>Iniciar Sesion</h1>
      <h2>Usuario</h2>
      <input type="text" placeholder="Ingresa tu suario" name="nombre">
      <h2>Contraseña</h2>
      <input type="password" placeholder="Ingresa tu contraseña" name="contra">
      @if($errors->has('nombre') || $errors->has('contra'))
        <p>nombre y contraseña requeridos</p>
      @endif
      @if($errors->has('cerror'))
        <p>usuario/contraseña incorrectos</p>
      @endif
      <a href="">¿Olvidó su contraseña?</a>
      <input type="submit" class="ingresar" style="display:none;">
      <a href="/validate" class="ingresar" method="post">Ingresar</a>
      <img src="{{asset('/images/logo-76aniversario.png')}}" width="80px" alt="Logo Aniversario Unison">
    </form>
    

  </div>
</body>
</html>