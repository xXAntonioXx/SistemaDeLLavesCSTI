<template>
    <div class="capa-cebolla1">
        <div class="ventanaModal1">
            <h4>Eliminar objeto(s)</h4>
            <div class="formEdit">
                <p>¿Seguro que desea eliminar los objetos seleccionados?</p>
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
    height: 60vh;
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
          objectsString:this.propObjectsString
        }
    },
    props:[
      'propObjectsString'
    ],
    methods:{
        saveChanges(cb){
            axios.post('/api/EliminarObjetos',{'objects':this.objectsString})
              .then(cb)
              .catch(err=>cb(err.response));
        }
    }
}
</script>

