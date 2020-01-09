<template>
    <div class="capa-cebolla1">
        <div class="ventanaModal1">
            <h4 id="cargar_llaves_titulo">Cargar llaves</h4>
            <section class="center-content">
            <form class="newUserForm specialClass" enctype="multipart/form-data">
              <div class="csv-expicacion">
                <p>Debe selecionar un archivo con extensión CSV, el cual deberá contener los siguientes campos:</p>
                <ol>
                  <li>Código de Llave 1</li>
                  <li>Código de Llave 2</li>
                  <li>Número de Aula</li>
                  <li>Área</li>
                  <li>Aula</li>
                </ol>
                <p>
                  Los campos deben estar en en el orden mencionado, deben estar delimitados por comas y la separación entre registros debe estar determinada por un salto de linea.
                  El archivo no debe contener el título de los campos (solamente debe contener los registros).
                </p>
              </div>
              <input type="file" name="archivo_fls" @change="obtenerImagen"/><br><br>
            </form>
          </section>
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
    /* margin-left:20px;  */
}
.formEdit label{
    font-size:0.7em; 
}
.formEdit input{
    width: 300px;
    height: 35px;
    background: #E8E8E8;
    border-radius: 20px;
    padding-left: 15px;
    border: none;
    font-size: 1em;
    margin-bottom: 0.5em;
}

.formEdit input:focus{
    outline-style: none;
}
.botonFin{
    border-radius: 50px;
    width: 75%;
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
    width: 75%;
    background: white;
    font-size: 70%;
    align-self: center;
    margin: auto;
    height: 30px;
}

.specialClass{
    display: flex;
    flex-direction: column;
    align-items: center;
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
            imagen:null,
        }
    },
    props:[
    ],
    methods:{
        obtenerImagen(e){
          let file = e.target.files[0];
          this.imagen= file;

        },
        addLlaves(cb){
          if(this.imagen!=null){
            let formData= new FormData();
            formData.append('archivo_fls',this.imagen);
            axios.post('/api/AgregarLlavescsv',formData)
              .then(cb)
              .catch(err=>cb(err.response));
          }else{
            toast.fire({
                icon: 'error',
                title: 'No hay archivo seleccionado'
              })
          }
        }
    }
}
</script>

