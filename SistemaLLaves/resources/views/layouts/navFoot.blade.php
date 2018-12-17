<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Prestamo de llaves</title>
  <link rel="icon" type="image/png" href="{{asset('/images/key.ico')}}">
  <link rel="stylesheet" href="{{asset('css/principal.css')}}">
</head>
<body onunload="">
  <div class="container-grid">
    <i class="icon-menu burger-button" id="burger-menu"></i>
    <header class="header">
      <figure class="logo" >
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
            <a href="/inventario" class="link">Inventario</a>
          </li>
          <li>
            <a href="#modal-soporte-container" class="link">Soporte</a>
          </li>
          <li>
            <a href="/salir" class="link">Salir</a>
          </li>
        </ol>
      </nav>
      <i class="icon-out log-out" id="log-out"></i>
      <div id="modal-soporte-container" class="modal-soporte-container">
        <div class="modal-soporte-content">
          <h2 class="modal-soporte-tittle">¿Tiene algún problema?</h3>
          <div class="modal-soporte-description">
            <h3>Asunto</h3>
            <input type="text" id="modal-soporte-asunto">
            <h3>Descripción</h3>
            <textarea rows="7" cols="68" id="modal-descripcion"></textarea>
          </div>
          <div class="modal-soporte-buttons">
            <input type="button" value="Enviar" class="modal-soporte-button-aceptar">
            <input type="button" value="Cancelar" class="modal-soporte-button-cancelar" onclick="window.location='#';">
          </div>
        </div>
      </div>
          
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

      window.onpageshow = function (event) {
        alert("se disparo el evento del cache");
        if (event.persisted) {
            window.location.reload();
        }
      };
    </script>
</body>
</html>