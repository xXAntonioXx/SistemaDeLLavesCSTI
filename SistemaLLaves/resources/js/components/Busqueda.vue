<template>
   <div class="search-results">
    <div class="search-results-tittle" id="REGISTROS">
      <h2>REGISTROS</h2>
    </div>
    {{this.showingRegistros.length}}
    <div class="search-results-content">
      <div class="search-results-content-card">
        <h3 id="search-results-id">1</h3>
        <div>
          <div>
            <h3 id="search-results-class">Estructura de datos</h3>
            <p id="search-results-date">19/12/2018</p>
          </div>
          <div>
            <p>Maestro/a: </p>
            <p id="search-results-teacher">Raquel Torres</p>
          </div>
          <div>
            <p>Aula: </p>
            <p id="search-results-classroom">5j-205</p>
          </div>
          <div>
            <p>Entrada:</p>
            <p id="search-results-start">12:00</p>
            <p>Salida:</p>
            <p id="search-results-end">13:00</p>
          </div>
          <div>
            <p id="search-results-objects">Prestamos</p>
            <div class="search-results-division"></div>
            <p class="search-results-symbol">&#9660;</p>
          </div>
          <div class="search-results-loanobjects">
            <div >
              <p id="search-results-objectname">Proyector</p>
              <p id="search-results-objectbrand">Cannon</p>
              <p id="search-results-objectstatus">Devuelto</p>
            </div>
            <div >
              <p id="search-results-objectname">Proyector</p>
              <p id="search-results-objectbrand">Cannon</p>
              <p id="search-results-objectstatus">Devuelto</p>
            </div>
            <div >
              <p id="search-results-objectname">Proyector</p>
              <p id="search-results-objectbrand">Cannon</p>
              <p id="search-results-objectstatus">Devuelto</p>
            </div>
          </div>
        </div>
      </div>
      <div class="search-results-content-card">
        <h3 id="search-results-id">1</h3>
        <div>
          <div>
            <h3 id="search-results-class">Estructura de datos</h3>
            <p id="search-results-date">19/12/2018</p>
          </div>
          <div>
            <p>Maestro/a: </p>
            <p id="search-results-teacher">Raquel Torres</p>
          </div>
          <div>
            <p>Aula: </p>
            <p id="search-results-classroom">5j-205</p>
          </div>
          <div>
            <p>Entrada:</p>
            <p id="search-results-start">12:00</p>
            <p>Salida:</p>
            <p id="search-results-end">13:00</p>
          </div>
          <div>
            <p id="search-results-objects">Prestamos</p>
            <div class="search-results-division"></div>
            <p class="search-results-symbol">&#9660;</p>
          </div>
          <div class="search-results-loanobjects">
            <div >
              <p id="search-results-objectname">Proyector</p>
              <p id="search-results-objectbrand">Cannon</p>
              <p id="search-results-objectstatus">Devuelto</p>
            </div>
            <div >
              <p id="search-results-objectname">Proyector</p>
              <p id="search-results-objectbrand">Cannon</p>
              <p id="search-results-objectstatus">Devuelto</p>
            </div>
            <div >
              <p id="search-results-objectname">Proyector</p>
              <p id="search-results-objectbrand">Cannon</p>
              <p id="search-results-objectstatus">Devuelto</p>
            </div>
          </div>
        </div>
      </div>
      <div class="search-results-content-card">
        <h3 id="search-results-id">1</h3>
        <div>
          <div>
            <h3 id="search-results-class">Estructura de datos</h3>
            <p id="search-results-date">19/12/2018</p>
          </div>
          <div>
            <p>Maestro/a: </p>
            <p id="search-results-teacher">Raquel Torres</p>
          </div>
          <div>
            <p>Aula: </p>
            <p id="search-results-classroom">5j-205</p>
          </div>
          <div>
            <p>Entrada:</p>
            <p id="search-results-start">12:00</p>
            <p>Salida:</p>
            <p id="search-results-end">13:00</p>
          </div>
          <div>
            <p id="search-results-objects">Prestamos</p>
            <div class="search-results-division"></div>
            <p class="search-results-symbol">&#9660;</p>
          </div>
          <div class="search-results-loanobjects">
            <div >
              <p id="search-results-objectname">Proyector</p>
              <p id="search-results-objectbrand">Cannon</p>
              <p id="search-results-objectstatus">Devuelto</p>
            </div>
            <div >
              <p id="search-results-objectname">Proyector</p>
              <p id="search-results-objectbrand">Cannon</p>
              <p id="search-results-objectstatus">Devuelto</p>
            </div>
            <div >
              <p id="search-results-objectname">Proyector</p>
              <p id="search-results-objectbrand">Cannon</p>
              <p id="search-results-objectstatus">Devuelto</p>
            </div>
          </div>
        </div>
      </div>
      <div class="search-results-content-card" v-for="registro in showingRegistros" :key="registro['id']">
        <h3 id="search-results-id">{{registro['id']}}</h3>
        <div>
          <div>
            <h3 id="search-results-class">{{registro['materia']}}</h3>
            <p id="search-results-date">{{registro['entrada'].slice(0,10)}}</p>
          </div>
          <div>
            <p>Maestro/a: </p>
            <p id="search-results-teacher">{{registro['maestro']}}</p>
          </div>
          <div>
            <p>Aula: </p>
            <p id="search-results-classroom">{{registro['aula']}}</p>
          </div>
          <div>
            <p>Entrada:</p>
            <p id="search-results-start">{{registro['entrada'].slice(10,16)}}</p>
            <p>Salida:</p>
            <p id="search-results-end">{{registro['salida'] ? registro['salida'].slice(10,16):''}}</p>
          </div>
          <div>
            <p id="search-results-objects">Prestamos</p>
            <div class="search-results-division"></div>
            <p class="search-results-symbol" @click="cargarObjetos(registro['id_prestamo'],registro['estadoBusqueda'],registro['id']);registro['estadoBusqueda']=!registro['estadoBusqueda']">&#9660;</p>
          </div>
          <div class="search-results-loanobjects">
            <div></div>
            <div >
              <p id="search-results-objectname">Proyector</p>
              <p id="search-results-objectbrand">Cannon</p>
              <p id="search-results-objectstatus">Devuelto</p>
            </div>
            <div >
              <p id="search-results-objectname">Proyector</p>
              <p id="search-results-objectbrand">Cannon</p>
              <p id="search-results-objectstatus">Devuelto</p>
            </div>
            <div >
              <p id="search-results-objectname">Proyector</p>
              <p id="search-results-objectbrand">Cannon</p>
              <p id="search-results-objectstatus">Devuelto</p>
            </div>
          </div>
        </div>
      </div>
      
    </div>
  </div>
</template>

<style scoped src="../../../public/css/principal.css">	
</style>

<script>
export default {
    data(){
        return{
          showingRegistros:this.registros,
          objetosAmostrar:{}
        }
    },
    props:[
      'registros'
    ],
    created:function(){
      this.showingRegistros.forEach(element => {
        element['estadoBusqueda']=true;

      });
      console.log(this.showingRegistros);
    },
    methods:{
      cargarObjetos(idPrestamo,estado,idReg){
        if(estado){
          let ruta =`api/obtenerObjetos/${idPrestamo}`;
          axios.get(ruta).then(res=>{
            let noExisteAun = true;
            if(!this.objetosAmostrar[idReg]){
              this.objetosAmostrar[idReg]=res.data;
            }
            console.log(JSON.stringify(this.objetosAmostrar));
            
          });
        }
      },
    }
}
</script>
