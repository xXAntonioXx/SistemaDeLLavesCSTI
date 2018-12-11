@extends('layouts.navFoot')
@section('cuerpo')
<div class="container-wrapper">
        <div class="search-container">
          <form action="" class="search-filters-form">
            <div class="search-filters-tittle">
              <h2>FILTROS</h2>
            </div>
            <div class="search-filters-content">
              <h3>Hora</h3>
              <div class="search-filters-hours">
                <input type="text" class="search-inputs">
                <p>a</p>
                <input type="text" class="search-inputs">
              </div>
              <h3>Dias</h3>
              <div class="search-filters-days">
                <p>Lun</p>
                <p>Mar</p>
                <p>Mie</p>
                <p>Jue</p>
                <p>Vie</p>
                <p>Sab</p>
              </div>
              <div class="search-filters-dayschecks">
                <input type="checkbox" name="Lun" id="Lun">
                <input type="checkbox" name="Mar" id="Mar">
                <input type="checkbox" name="Mie" id="Mie">
                <input type="checkbox" name="Jue" id="Jue">
                <input type="checkbox" name="Vie" id="Vie">
                <input type="checkbox" name="Sab" id="Sab">
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
          <div class="search-results">
            <div class="search-results-tittle" id="REGISTROS">
              <h2>REGISTROS</h2>
            </div>
            <div class="search-results-content">
              <div class="search-results-content-card">
                <h3 id="search-results-id">1</h3>
                <div>
                  <h3 id="search-results-class">Estructura de datos</h3>
                  <div>
                    <p id="search-results-classroom">5j-205</p>
                    <p id="search-results-teacher">Raquel Torres</p>
                  </div>
                  <div>
                    <p id="search-results-hour">12:00-13:00</p>
                    <p id="search-results-days">Lun, Mar, Mie, Jue</p>
                  </div>
                  <p id="search-results-objects">Prestamos</p>
                  <div class="search-results-loanobjects">
                    <p id="search-results-objectname">Proyector</p>
                    <p id="search-results-objectbrand">Cannon</p>
                    <p id="search-results-objectstatus">Devuelto</p>
                  </div>
                </div>
              </div>
              <div class="search-results-content-card">
                <h3 id="search-results-id">1</h3>
                <div>
                  <h3 id="search-results-class">Estructura de datos</h3>
                  <div>
                    <p id="search-results-classroom">5j-205</p>
                    <p id="search-results-teacher">Raquel Torres</p>
                  </div>
                  <div>
                    <p id="search-results-hour">12:00-13:00</p>
                    <p id="search-results-days">Lun, Mar, Mie, Jue</p>
                  </div>
                  <p id="search-results-objects">Prestamos</p>
                  <div class="search-results-loanobjects">
                    <p id="search-results-objectname">Proyector</p>
                    <p id="search-results-objectbrand">Cannon</p>
                    <p id="search-results-objectstatus">Devuelto</p>
                  </div>
                </div>
              </div>
              <div class="search-results-content-card">
                <h3 id="search-results-id">1</h3>
                <div>
                  <h3 id="search-results-class">Estructura de datos</h3>
                  <div>
                    <p id="search-results-classroom">5j-205</p>
                    <p id="search-results-teacher">Raquel Torres</p>
                  </div>
                  <div>
                    <p id="search-results-hour">12:00-13:00</p>
                    <p id="search-results-days">Lun, Mar, Mie, Jue</p>
                  </div>
                  <p id="search-results-objects">Prestamos</p>
                  <div class="search-results-loanobjects">
                    <p id="search-results-objectname">Proyector</p>
                    <p id="search-results-objectbrand">Cannon</p>
                    <p id="search-results-objectstatus">Devuelto</p>
                  </div>
                </div>
              </div>
              <div class="search-results-content-card">
                <h3 id="search-results-id">1</h3>
                <div>
                  <h3 id="search-results-class">Estructura de datos</h3>
                  <div>
                    <p id="search-results-classroom">5j-205</p>
                    <p id="search-results-teacher">Raquel Torres</p>
                  </div>
                  <div>
                    <p id="search-results-hour">12:00-13:00</p>
                    <p id="search-results-days">Lun, Mar, Mie, Jue</p>
                  </div>
                  <p id="search-results-objects">Prestamos</p>
                  <div class="search-results-loanobjects">
                    <p id="search-results-objectname">Proyector</p>
                    <p id="search-results-objectbrand">Cannon</p>
                    <p id="search-results-objectstatus">Devuelto</p>
                  </div>
                </div>
              </div>
              <div class="search-results-content-card">
                <h3 id="search-results-id">1</h3>
                <div>
                  <h3 id="search-results-class">Estructura de datos</h3>
                  <div>
                    <p id="search-results-classroom">5j-205</p>
                    <p id="search-results-teacher">Raquel Torres</p>
                  </div>
                  <div>
                    <p id="search-results-hour">12:00-13:00</p>
                    <p id="search-results-days">Lun, Mar, Mie, Jue</p>
                  </div>
                  <p id="search-results-objects">Prestamos</p>
                  <div class="search-results-loanobjects">
                    <p id="search-results-objectname">Proyector</p>
                    <p id="search-results-objectbrand">Cannon</p>
                    <p id="search-results-objectstatus">Devuelto</p>
                  </div>
                </div>
              </div>
              <div class="search-results-content-card">
                <h3 id="search-results-id">1</h3>
                <div>
                  <h3 id="search-results-class">Estructura de datos</h3>
                  <div>
                    <p id="search-results-classroom">5j-205</p>
                    <p id="search-results-teacher">Raquel Torres</p>
                  </div>
                  <div>
                    <p id="search-results-hour">12:00-13:00</p>
                    <p id="search-results-days">Lun, Mar, Mie, Jue</p>
                  </div>
                  <p id="search-results-objects">Prestamos</p>
                  <div class="search-results-loanobjects">
                    <p id="search-results-objectname">Proyector</p>
                    <p id="search-results-objectbrand">Cannon</p>
                    <p id="search-results-objectstatus">Devuelto</p>
                  </div>
                </div>
              </div>
              <div class="search-results-content-card">
                <h3 id="search-results-id">1</h3>
                <div>
                  <h3 id="search-results-class">Estructura de datos</h3>
                  <div>
                    <p id="search-results-classroom">5j-205</p>
                    <p id="search-results-teacher">Raquel Torres</p>
                  </div>
                  <div>
                    <p id="search-results-hour">12:00-13:00</p>
                    <p id="search-results-days">Lun, Mar, Mie, Jue</p>
                  </div>
                  <p id="search-results-objects">Prestamos</p>
                  <div class="search-results-loanobjects">
                    <p id="search-results-objectname">Proyector</p>
                    <p id="search-results-objectbrand">Cannon</p>
                    <p id="search-results-objectstatus">Devuelto</p>
                  </div>
                </div>
              </div>
              <div class="search-results-content-card">
                <h3 id="search-results-id">1</h3>
                <div>
                  <h3 id="search-results-class">Estructura de datos</h3>
                  <div>
                    <p id="search-results-classroom">5j-205</p>
                    <p id="search-results-teacher">Raquel Torres</p>
                  </div>
                  <div>
                    <p id="search-results-hour">12:00-13:00</p>
                    <p id="search-results-days">Lun, Mar, Mie, Jue</p>
                  </div>
                  <p id="search-results-objects">Prestamos</p>
                  <div class="search-results-loanobjects">
                    <p id="search-results-objectname">Proyector</p>
                    <p id="search-results-objectbrand">Cannon</p>
                    <p id="search-results-objectstatus">Devuelto</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
</div>
@stop