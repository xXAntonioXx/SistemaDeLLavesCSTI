<template>
    <div class="capa-cebolla1">
        <div class="ventanaModal1">
            <h4>{{this.accion}} objeto{{this.nombre}}</h4>
            <div class="formEdit">
                <label for="nombre">Nombre:</label>
                <input id="nombre" type="text" v-model="nombre" placeholder="Nombre del objeto"><br>
                <label for="marca">Marca:</label>
                <input id="marca" type="text" v-model="marca" placeholder="Marca del objeto"><br>
                <label for="descripcion">Descripción:</label>
                <textarea id="descripcion" placeholder="Caracteristicas y/o detalles" v-model="descripcion"></textarea><br>
                <label for="cantidad">Cantidad:</label>
                <input type="number" id="cantidad" v-model="cantidad">
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
            nombre:(this.propNombre) ? this.propNombre:'' ,
            id:(this.propIdObjeto) ? this.propIdObjeto:0,
            marca:(this.propMarca) ? this.propMarca:'',
            descripcion:(this.propDescripcion) ? this.propDescripcion:'',
            cantidad:(this.propCantidad) ? this.propCantidad:'1'
        }
    },
    props:[
        'propAccionRealizar',
        'propNombre',
        'propIdObjeto',
        'propMarca',
        'propDescripcion',
        'propCantidad'
    ],
    methods:{
        saveChanges(cb){

          if(this.nombre!='' || this.marca!='' || this.descripcion!='' || this.cantidad>1) {
            if(this.accion=='Agregar'){
              axios.post('/api/agregarObjeto',{'nombre':this.nombre,'marca':this.marca,'descripcion':this.descripcion,'cantidad':this.cantidad})
                .then(cb)
                .catch(err=>cb(err.response));
            }else if(this.accion=='Modificar'){
              
            }
          }else{
            toast.fire({
              icon: 'error',
              title: 'Alguno de los campos se encuentra vacío.'
            })
          }
            // if(this.nuevoContra==this.nuevoContraRep){
            //     this.nuevoContra = this.nuevoContra==''&&this.nuevoContra==' '?null:this.nuevoContra;
            //     axios.put('/api/actualizarUsuario',{'id':this.id,'contraseña':this.nuevoContra,'rol':this.nuevoRol})
            //         .then(cb)
            //         .catch(err=>cb(err.response));
            // }else{
            //     toast.fire({
            //         icon: 'error',
            //         title: 'Las contraseñas no coinciden.'
            //     })
            // }
        }
    }
}
</script>

