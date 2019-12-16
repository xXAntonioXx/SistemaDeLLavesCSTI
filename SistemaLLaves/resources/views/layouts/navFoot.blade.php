<!DOCTYPE html>
<html lang="es">
<head>
  <meta name="csrf-token" content="{{csrf_token()}}">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Prestamo de llaves</title>
  <link rel="icon" type="image/png" href="{{asset('/images/key.ico')}}">
  <link rel="stylesheet" href="{{asset('css/principal.css')}}">
  <link rel="stylesheet" href="{{asset('css/admin.css')}}">
</head>
<body>
  <div class="container-grid">
    <i class="icon-menu burger-button" id="burger-menu"></i>
    <header class="header">
      <figure class="logo" >
        <a style="display:block; height:100%; width:100%;" href="/main"></a>
      </figure>
      <h1>PRÉSTAMO DE LLAVES</h1>
      <nav >
        <ol class="menu">
          @if(Session::get('rol')==1)
          <li>
            <a href="/panel" class="link">Panel</a>
          </li>
          @endif
          <li>
            <a href="/main" class="link">Inicio</a>
          </li>
          <li>
            <a href="/busqueda" class="link">Búsqueda</a>
          </li>
          <li>
            <a href="/inventario" class="link">Inventario</a>
          </li>
          <li>
            <a href="#modal-soporte-container" class="link">Soporte</a>
          </li>
          <li>
           <a href="/salir" ><i class="icon-salir salir"></i></a>
           
          </li>
        </ol>
      </nav>
      <i class="icon-out log-out" id="log-out"></i>
      <div id="modal-soporte-container" class="modal-soporte-container">
        <form action="/enviarObservacion" method="post" class="modal-soporte-content">
          {{csrf_field()}}
          <h2 class="modal-soporte-tittle">Reportar problema</h3>
          <div class="modal-soporte-description">
            <h3>Asunto</h3>
            <input type="text" id="modal-soporte-asunto" name="asunto">
            <h3>Descripción</h3>
            <textarea rows="7" cols="68" id="modal-descripcion" name="description"></textarea>
          </div>
          <div class="modal-soporte-buttons">
            <input type="submit" value="Enviar" class="modal-soporte-button-aceptar">
            <input type="button" value="Cancelar" class="modal-soporte-button-cancelar" onclick="window.location='#';">
          </div>
        </form>
      </div>
          
        </ol>
      </nav>
      <i class="icon-out log-out" id="log-out"></i>
    </header>
    @yield('cuerpo')
    <footer class="footer">
      <h3>&copy; Derechos Reservados 2018-2019</h3>
      <h3>&lsaquo; Acerca de Nosotros &rsaquo;</h3>
    </footer>
  </div>
  <!--/div-->
  <script>
      window.addEventListener("pageshow",(event)=>{
        var historyTraversal = event.persisted || ( typeof window.performance != "undefined" && window.performance.navigation.type === 2 );
        if ( historyTraversal ) {
         // Handle page restore.
          window.location.reload();
        }
      });
      const ipad = window.matchMedia('screen and (max-width: 767px)');
      const arrows = document.querySelectorAll('.search-results-symbol');
      const loanObjects = document.querySelectorAll('.search-results-loanobjects');
      const menu = document.querySelector('.menu');
      const nav = document.querySelector('nav');
      const burgerButton = document.querySelector('#burger-menu');
      function addClassToObjects() {
        for(var i = 0; i < arrows.length; i++){
          loanObjects[i].setAttribute('id', 'element-'+i);
          let id = loanObjects.item(i).getAttribute('id');
          arrows[i].addEventListener('click', function(){ hideShowObjects(id) } );
        }
      }
      addClassToObjects()
      ipad.addListener(validation);
      function validation(event){
        if(event.matches){
          burgerButton.addEventListener('click', hideShow);
        } else {
          burgerButton.removeEventListener('click', hideShow);
        }
      }
      validation(ipad);
      function hideShowObjects(id) {
        for(let i = 0; i < loanObjects.length; i++){
          if(loanObjects[i].getAttribute('id')===id) {
            if(loanObjects[i].classList.contains('is-active')){
              loanObjects[i].classList.remove('is-active');
              arrows[i].classList.remove('rotation');
            }else {
              loanObjects[i].classList.add('is-active');
              arrows[i].classList.add('rotation');
            }
          }
        }
      }
      function removeHamburguer(){
        // console.log(window.outerWidth);
        if(window.outerWidth>767){
          nav.classList.remove('is-active');
          menu.classList.remove('is-active');
        }
      }
      function hideShow(){
        if(menu.classList.contains('is-active')){
          nav.classList.remove('is-active');
          menu.classList.remove('is-active');
        }else {
          nav.classList.add('is-active');
          menu.classList.add('is-active');
        }
      }
    </script>
</body>
</html>