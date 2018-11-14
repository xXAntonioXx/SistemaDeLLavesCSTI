@extends('layouts.navFoot')
@section('cuerpo')
    <div id="app">
      <registro></registro>
    </div>
    <script src="{{asset('js/app.js')}}"></script>
    
    <!--section class="llaves-prestadas">
      <h2>Llaves prestadas</h2>
      <div class="division"></div>
      <div class="llaves-titles">
        <h3>ID</h3>
        <h3>MAESTRO</h3>
        <h3>MATERIA</h3>
        <h3>SALON</h3>
        <h3>HORA</h3>
      </div>
      <div class="division"></div>
      <div class="llaves-cards">
        <div class="card-item">
          <h3>2</h3>
          <h3>Ciret</h3>
          <h3>Estructura</h3>
          <h3>5j-205</h3>
          <h3>12:00</h3>
        </div>
      </div>
      <div class="llaves-paginador">
        <ul>
          <li><a>1</a></li>
          <li><a>2</a></li>
          <li><a>3</a></li>
          <li><a>4</a></li>
          <li><a>5</a></li>
        </ul>
      </div>
    </section-->
    <div class="container-grid">
    <section class="formulario-prestamo">
      <div class="formulario-tittle">
          <h2>Formulario de prestamo</h2>
          <div class="ghost-div"></div>
      </div>
      <form action="" class="formulario-prestamo-content">
        <h3 class="llaves">No. Llave</h3>
        <h3 class="maestros">Maestro</h3>
        <h3 class="materia">Materia</h3>
        <h3 class="aula">Aula</h3>
        <h3 class="hora">Hora</h3>
        <select class="combo-box inputs">
          <option value="Rivera Samudio">Rivera Samudio</option>
          <option value="Lab-IQ">Lab-IQ</option>
          <option value="Lab-Mecatronica">Lab-Mecatronica</option>
        </select>
        <input class="llaves-i inputs" type="text">
        <input class="maestros-i inputs" type="text">
        <input class="materia-i inputs" type="text">
        <input class="aula-i inputs" type="text">
        <input class="hora-i inputs" type="text">
      </form>
      <div class="button-registro">
          <input type="submit" value="Registrar" class="registrar" onclick="window.location='#modal-container';"/>
      </div>
      <div id="modal-container" class="modal-container">
        <div class="modal-content">
          <h3 class="modal-tittle">Lista de articulos</h3>
          <div class="modal-list">
            <select class="combo-box" name="modal-article-list" id="modal-article-list">
              <option value="Bocinas">Bocinas</option>
              <option value="Bocinas">Bocinas</option>
            </select>
            <select class="combo-box" name="modal-article-list" id="modal-article-list">
              <option value="Bocinas">Control</option>
              <option value="Bocinas">Bocinas</option>
            </select>
          </div>
          <div class="modal-buttons">
            <input type="button" value="Aceptar" class="modal-button-aceptar">
            <input type="button" value="Cancelar" class="modal-button-cancelar" onclick="window.location='#';">
          </div>
        </div>
      </div>
    </section>
    </div>
  <script>
      const ipad = window.matchMedia('screen and (max-width: 744px)');
      const menu = document.querySelector('.menu');
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
        }else {
          menu.classList.add('is-active');
        }
      }
    </script>
@stop