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
    <form action="/Iniciar-sesion/" class="inicio-sesion">
      <h1>Iniciar Sesion</h1>
      <h2>Usuario</h2>
      <input type="text" placeholder="Ingresa tu suario">
      <h2>Contraseña</h2>
      <input type="password" placeholder="Ingresa tu contraseña">
      <a href="">¿Olvidó su contraseña?</a>
      <a href="principal.html" class="ingresar">Ingresar</a>
      <img src="images/logo-76aniversario.png" width="80px" alt="Logo Aniversario Unison">
    </form>
  </div>
</body>
</html>