<template>
<div class="body-container">
    <section class="llaves-prestadas">
      <h2 class="llaves-prestadas-tittle">Llaves prestadas</h2>
      <!--div class="division"></div-->
      <div class="llaves-titles">
        <h3>ID</h3>
        <h3>MAESTRO</h3>
        <h3>MATERIA</h3>
        <h3>SALON</h3>
        <h3>HORA</h3>
      </div>
      <div class="llaves-cards">
        <div v-for="registro in Paginate" class="card-item" :key="registro['id']">
            <h3>{{registro['id']}}</h3>
            <h3>{{registro['maestro']}}</h3>
            <h3>{{registro['materia']}}</h3>
            <h3>{{registro['salon']}}</h3>
            <h3>{{ registro['hora_entrada'].split(" ")[1] }}</h3>
        </div>
      </div>
      <div class="llaves-paginador">
        <ul>
          <li v-for="n in paginas">
            <a @click="getPages(n)">{{n}}</a>
          </li>
        </ul>
      </div>
    </section>
    <section class="formulario-prestamo">
      <div class="formulario-tittle">
          <h2>Formulario de prestamo</h2>
          <div class="ghost-div"></div>
      </div>
      <div class="formulario-wrapper">
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
            <input @keyup.enter="buscarHorario(codigoKey)" class="llaves-i inputs" type="text" v-model="codigoKey">
            <input class="maestros-i inputs" type="text" v-model="registroForm['maestro']" :disabled="validate=estadoInput">
            <input class="materia-i inputs" type="text" v-model="registroForm['materia']" :disabled="validate=estadoInput">
            <input class="aula-i inputs" type="text" v-model="registroForm['aula']" :disabled="validate=estadoInput">
            <input class="hora-i inputs" type="text" v-model="registroForm['hora']" :disabled="validate=estadoInput">
        </form>
      </div>

      <div class="button-registro">
          <input type="submit" value="Registrar" class="registrar" onclick="window.location='#modal-container';"/>
      </div>
      <div id="modal-container" class="modal-container">
        <div class="modal-content">
          <h3 class="modal-tittle">Lista de articulos</h3>
          <div class="modal-list">
            <select class="combo-box" name="modal-article-list" id="modal-article-list" v-for="comboInd in comboIterates" @change="agregarCombo(comboInd)" :key="comboInd">
              <option value="Bocinas">Bocinas</option>
              <option value="Bocinas">Control Cañon</option>
              <option value="Bocinas">Control A/AC</option>
            </select>
          </div>
          <div class="modal-buttons">
            <input type="button" value="Aceptar" class="modal-button-aceptar" v-on:click="showTime">
            <input type="button" value="Cancelar" class="modal-button-cancelar" onclick="window.location='#';">
          </div>
        </div>
      </div>
    </section>
    </div>
</template>

<style scoped src="../../../public/css/principal.css">	
</style>

<script>
import moment from 'moment-timezone';
//const mom = require('moment');

export default {
    data(){
        return{
            Pages:[],
            indicePagina:1,
            paginas:1,
            codigoKey:'',
            registroForm:[],
            estadoInput:false,
            comboIterates:1
        }
    },
    created(){
      this.fetchRegistros();
    },
    computed:{
      Paginate(){
        return this.Pages.slice(7*(this.indicePagina-1),7*this.indicePagina);
      },
    },
    methods:{
      fetchRegistros(){
        fetch('api/registros')
        .then(res=>res.json())
        .then(data=>{
          this.paginas=Math.ceil(data.length/7);
          this.Pages=data;
        });
      },

      getPages(nPage){
        this.indicePagina=nPage;
      },

      showTime(caso=1){
        let timez = moment.tz.guess();
        let FechaHora = moment.tz(timez).format("YYYY-M-D HH:mm:ss");
        let hora=moment.tz(timez).format("HH:mm:ss");
        return caso==1?FechaHora:hora;
      },

      buscarHorario(codigoLLave){
        /*axios.post('/api/buscarHorario',{'codigo':codigoLLave,'timez':this.showTime()})
          .then(dumb=>console.log(dumb));*/
        let time=this.showTime();
        let busqueda = `api/buscarHorario/${codigoLLave}/${time}`;
        console.log("se hace busqueda: "+busqueda);
        axios.get(busqueda)
        .then(res=>{
          this.registroForm=res.data;
          this.registroForm['hora']=this.showTime(2);
          this.estadoInput=true;
        });
      },

      agregarCombo(identificador){
        if(identificador==this.comboIterates){
          this.comboIterates++;
        }
      }
    }
}
</script>
