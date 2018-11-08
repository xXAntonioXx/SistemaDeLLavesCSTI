@extends('layouts.navFoot')
@section('cuerpo')
    <section class="llaves-prestadas">
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
    </section>
    <section class="formulario-prestamo">
      <h2>Formulario de prestamo</h2>
      <div class="division"></div>
      <form action="">
        <div class="row-container lista-llaves">
          <input class="combo-box" list="salones" name="salones" placeholder="Llaves únicas y diferentes">
          <datalist id="salones">
            <option value="Rivera Samudio">Rivera Samudio</option>
            <option value="Lab-IQ">Lab-IQ</option>
            <option value="Lab-Mecatronica">Lab-Mecatronica</option>
          </datalist>
        </div>
        <div class="row-container">
          <h3 href="">No. Llave</h3>
          <input type="text">
        </div>
        <div class="row-container">
            <h3 href="">Maestro</h3>
            <input type="text">
        </div>
        <div class="row-container">
            <h3 href="">Materia</h3>
            <input type="text">
        </div>
        <div class="row-container pequeños">
            <h3 href="">Aula</h3>
            <input type="text">
            <h3 href="" class="title-hora">Hora</h3>
          <input type="text">
        </div>
      </form>
      <div class="button-registro">
          <input type="submit" value="Ingresar" class="registrar"/>
      </div>
    </section>
    <!-- <div class="container-sections">
    </div> -->
@stop