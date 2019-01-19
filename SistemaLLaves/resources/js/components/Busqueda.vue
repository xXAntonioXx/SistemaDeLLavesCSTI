<template>
   <div class="search-results">
    <div class="search-results-tittle" id="REGISTROS">
      <h2>REGISTROS</h2>
    </div>

    <div class="search-results-content">
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
            <p id="search-results-objects">Préstamos</p>
            <div class="search-results-division"></div>
            <p class="search-results-symbol" @click="cargarObjetos(registro['id_prestamo'],registro['estadoBusqueda'],registro['id']);registro['estadoBusqueda']=!registro['estadoBusqueda'];">&#9660;</p>
          </div>
          <div class="search-results-loanobjects">
            <div v-for="obj in objetosRegistro[registro['id']]" :key="obj['id']">
              <p id="search-results-objectname">{{obj['nombre']}}</p>
              <p id="search-results-objectbrand">{{obj['marca']}}</p>
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
          objetosAmostrar:{},
          auxiliar:{},
          idAuxiliar:'',
          Objeto:[]
        }
    },
    props:[
      'registros'
    ],
    computed:{
      objetosRegistro(){
        let id = this.idAuxiliar;
        let contenido=this.Objeto;
        this.objetosAmostrar[id]=contenido
        return this.objetosAmostrar;
      }
    },
    created:function(){
      this.showingRegistros.forEach(element => {
        element['estadoBusqueda']=true;

      });
    },
    methods:{
       cargarObjetos(idPrestamo,estado,idReg){
        if(estado){
          let ruta =`api/obtenerObjetos/${idPrestamo}`;
          axios.get(ruta).then(res=>{
            let noExisteAun = true;
            if(!this.objetosAmostrar[idReg]){
              this.idAuxiliar=idReg;
              this.Objeto=res.data;
              this.objetosAmostrar[idReg]=res.data;
            }  
          });
        }
      },
    }
}
</script>
