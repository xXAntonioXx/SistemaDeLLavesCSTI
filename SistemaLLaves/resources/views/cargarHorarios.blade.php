@extends('layouts.navFoot')
@section('cuerpo')
<div class="primary-content">
  
  <div class="section-title">
    <h2>Registrar Horarios</h2>
  </div>
  <section class="center-content">
    <form class="newUserForm" method="POST" action="/AgregarHorario" accept-charset="utf-8" enctype="multipart/form-data">
          {{csrf_field()}}
          <div>
          <strong>Año:</strong> <br>
          <select name="year" class="dropdown">
              <?php
                  for($i=0; $i<4; $i++){
                    $var=date("Y")+$i;
                    echo '<option value="'. $var .'">'. $var .'</option>';
                  }
              ?>
          </select>
          </div><br>
          <div>
          <strong>Ciclo escolar:</strong> <br>
          <select name="ciclo" class="dropdown">
              <option value="1">Enero-Mayo</option>
              <option value="2">Junio</option>
              <option value="3">Agoto-Diciembre</option>
          </select>
          </div><br>
          <input type="file" name="archivo_fls"/><br><br>
          <input class="submitBtn" type="submit" name="enviar" value="Cargar Archivo"/>
      </form>
    </section>
</div>

@stop