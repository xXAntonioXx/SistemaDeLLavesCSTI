<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Prestamo de llaves</title>
  <link rel="icon" type="image/png" href="images/key.png">
  <link rel="stylesheet" href="{{asset('/css/principal.css')}}">
</head>
<body>
  <div class="container-grid">
    <i class="icon-menu burger-button" id="burger-menu"></i>
    <header class="header">
      <figure class="logo">
        <img src="{{asset('/images/log-unison.png')}}" alt="logo-unison" width="60%">
      </figure>
      <h1>PRESTAMO DE LLAVES</h1>
      <nav >
        <ol class="menu">
          <li>
            <a href="index.html" class="link">Inicio</a>
          </li>
          <li>
            <a href="busqueda.html" class="link">Busqueda</a>
          </li>
          <li>
            <a href="inventario.html" class="link">Inventario</a>
          </li>
          <li>
            <a href="soporte.html" class="link">Soporte</a>
          </li>
        </ol>
      </nav>
      <figure class="imagen-perfil">
        <img src="{{asset('/images/log-unison.png')}}" alt="imagen-de-perfil" width="50px">
      </figure>
    </header>

    @yield('cuerpo')

    <footer class="footer">
      <a href="">Derechos Reservados</a>
      <a href="">Acerca de Nosotros</a>
    </footer>
  </div>
  <script>
      // console.log('Hola perroooooos!!!!');
      const ipad = window.matchMedia('screen and (max-width: 656px)');
      const menu = document.querySelector('.menu');
      const img_perfil = document.querySelector('.imagen-perfil');
      // console.log(menu);
      const burgerButton = document.querySelector('#burger-menu');
      // console.log(burgerButton);
      
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
        if(menu.classList.contains('is-active') && img_perfil.classList.contains('is-active')){
          menu.classList.remove('is-active');
          img_perfil.classList.remove('is-active');
        }else {
          menu.classList.add('is-active');
          img_perfil.classList.add('is-active');
        }
      }
    </script>
</body>
</html>