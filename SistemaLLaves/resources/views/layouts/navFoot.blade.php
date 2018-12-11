<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Prestamo de llaves</title>
  <link rel="icon" type="image/png" href="images/key.png">
  <link rel="stylesheet" href="{{asset('css/principal.css')}}">
</head>
<body>
  <div class="container-grid">
    <i class="icon-menu burger-button" id="burger-menu"></i>
    <header class="header">
      <figure class="logo">
        <a style="display:block; height:100%; width:100%;" href="/main"></a>
      </figure>
      <h1>PRESTAMO DE LLAVES</h1>
      <nav >
        <ol class="menu">
          <li>
            <a href="/main" class="link">Inicio</a>
          </li>
          <li>
            <a href="/busqueda" class="link">Busqueda</a>
          </li>
          <li>
            <a href="inventario.html" class="link">Inventario</a>
          </li>
          <li>
            <a href="soporte.html" class="link">Soporte</a>
          </li>
          <li>
            <a href="/salir" class="link">Salir</a>
          </li>
        </ol>
      </nav>
      <i class="icon-out log-out" id="log-out"></i>
    </header>
    @yield('cuerpo')
    <footer class="footer">
      <h3>&copy; Derechos Reservados</h3>
      <h3>&lsaquo; Acerca de Nosotros &rsaquo;</h3>
    </footer>
  </div>
  <!--/div-->
  <script>
      const ipad = window.matchMedia('screen and (max-width: 767px)');
      const menu = document.querySelector('.menu');
      const nav = document.querySelector('nav');
      const burgerButton = document.querySelector('#burger-menu');
      ipad.addListener(validation);
      function validation(event){
        if(event.matches){
          burgerButton.addEventListener('click', hideShow);
        } else {
          burgerButton.removeEventListener('click', hideShow);
        }
      }
      validation(ipad);
      function hideShow(){
        if(menu.classList.contains('is-active')){
          menu.classList.remove('is-active');
          nav.classList.remove('is-active');
        }else {
          menu.classList.add('is-active');
          nav.classList.add('is-active');
        }
      }
    </script>
</body>
</html>