@extends('layouts.navFoot')
@section('cuerpo')
<div class="container-wrapper">
  <div class="search-container">
    <form action="" class="search-filters-form">
      <div class="search-filters-tittle">
        <h2>FILTROS</h2>
      </div>
      <div class="search-filters-content">
        <h3>Fecha</h3>
        <div class="search-filters-days">
          <input type="date" class="search-inputs date">
          <p>a</p>
          <input type="date" class="search-inputs date">
        </div>
        <h3>Hora</h3>
        <div class="search-filters-hours">
          <select class="search-inputs hours">
            <option value="07:00">07:00</option>
            <option value="08:00">08:00</option>
            <option value="09:00">09:00</option>
            <option value="10:00">10:00</option>
            <option value="11:00">11:00</option>
            <option value="12:00">12:00</option>
            <option value="13:00">13:00</option>
            <option value="14:00">14:00</option>
            <option value="15:00">15:00</option>
            <option value="16:00">16:00</option>
            <option value="17:00">17:00</option>
            <option value="18:00">18:00</option>
            <option value="19:00">19:00</option>
            <option value="20:00">20:00</option>
            <option value="21:00">21:00</option>
            <option value="22:00">22:00</option>
          </select>
          <p>a</p>
          <select class="search-inputs hours">
            <option value="07:59">07:59</option>
            <option value="08:59">08:59</option>
            <option value="09:59">09:59</option>
            <option value="10:59">10:59</option>
            <option value="11:59">11:59</option>
            <option value="12:59">12:59</option>
            <option value="13:59">13:59</option>
            <option value="14:59">14:59</option>
            <option value="15:59">15:59</option>
            <option value="16:59">16:59</option>
            <option value="17:59">17:59</option>
            <option value="18:59">18:59</option>
            <option value="19:59">19:59</option>
            <option value="20:59">20:59</option>
            <option value="21:59">21:59</option>
            <option value="22:59">22:59</option>
          </select>
        </div>
        <div class="search-filters-section">
          <h3>Maestro</h3>
          <input type="text" class="search-inputs">
        </div>
        <div class="search-filters-section">
          <h3>Materia</h3>
          <input type="text" class="search-inputs">
        </div>
        <div class="search-filters-section">
          <h3>Aula</h3>
          <input type="text" class="search-inputs">
        </div>
      </div>
      <div class="search-filters-button">
        <input type="submit" value="Buscar" class="filters-button" onclick="window.location='#REGISTROS';">
      </div>
    </form>
    <div id="app">
        <busqueda></busqueda>
    </div>
  </div>
</div>
<script src="{{asset('js/app.js')}}"></script>
@stop