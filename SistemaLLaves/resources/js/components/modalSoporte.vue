<template>
    <div class="capa-cebolla1">
        <div class="ventanaModal1">
            <h4>{{this.accion}} reporte</h4>
            <div class="formEdit">
                <label for="aula">Aula:</label>
                <select name="aula" id="aula" class="dropdown" v-model="aula">
                  <option value="0" disabled>Seleccionar...</option>
                  <option v-for="option in options" :key="'aula-num-'+option['numero']" v-bind:value="option['numero']">{{option['aula']}}</option>
                </select>
                <label for="descripcion">Descripción:</label>
                <textarea id="descripcion" placeholder="Detalles del problema" v-model="descripcion"></textarea><br>
            </div>
            <div class="opcionesB">
                <slot></slot>
            </div>
        </div>
    </div>
</template>
<style>
.capa-cebolla1{
    position: fixed;
    z-index: 1;
    background-color: rgba(0, 0, 0,.5);
    height: 100%;
    width: 100%;
    display:flex;
    top: 0;
    left: 0;
    bottom: 100%;
}
.ventanaModal1{
    height: 80vh;
    width: 500px;
    margin: auto;
    border-radius: 5px;
    position: relative;
    align-items: center;
    background: white;
    z-index: 3;
    overflow: auto;
    border: 2px solid grey;
    align-content: space-evenly;
}
.formEdit{
    text-align: center;
}
.formEdit h4{
  margin-bottom: 2px;
  margin-top: 15px;
}
.formEdit label{
  display: block;
  margin-bottom: -12px; 
  font-size:0.7em; 
}
.formEdit input{
    width: 300px;
    height: 25px;
    background: #E8E8E8;
    border-radius: 20px;
    padding-left: 15px;
    border: none;
    font-size: 0.6em;
    margin-bottom: 0.5em;
}

.formEdit textarea {
    margin-top: 10px;
    border-radius: 10px;
    width: 290px;
    background: #E8E8E8;
    font-size: 0.6em;
    padding: 5px 10px;
    font-family: Hind,sans-serif;
}

.formEdit input:focus{
    outline-style: none;
}
.botonFin{
    border-radius: 50px;
    width: 45%;
    background: #004990;
    font-size: 70%;
    color: white;
    display: flex;
    justify-content: center;
    margin: auto;
    height: 30px;
}

.botonCancelar{
    border: 2px solid #004990;
    border-radius: 50px;
    width: 45%;
    background: white;
    font-size: 70%;
    align-self: center;
    margin: auto;
    height: 30px;
}
.opcionesB{
    width: 90%;
    display: grid;
    margin: 0 auto;
    grid-template-columns: 1fr 1fr;
}
</style>

<script>
export default {
    data(){
        return{
            accion:this.propAccionRealizar,
            options:{},
            aula:(this.propAula) ? this.propAula : 0,
            descripcion:(this.propDescripcion) ? this.propDescripcion.toLowerCase():'',
        }
    },
    props:[
        'propAccionRealizar',
        'propDescripcion',
        'propAula'
    ],
    created(){
      this.fetchAulas();
    },
    methods:{
        fetchAulas(){
          axios.get('/api/obtenerAulas')
          .then(data=>{
            this.options=data['data'];
          });
        },
        saveChanges(cb){
          if(this.descripcion!='' && (this.aula!=0 && this.aula!=null)){
            if(this.accion=='Registrar'){
              axios.post('/api/agregarReporte',{'aula':this.aula,'descripcion':this.descripcion})
                .then(cb)
                .catch(err=>cb(err.response))
            }
          }else{
            toast.fire({
              icon: 'error',
              title: 'Seleccione un aula y agrege una descripción al reporte.'
            })
          }
        }
    }
}
</script>