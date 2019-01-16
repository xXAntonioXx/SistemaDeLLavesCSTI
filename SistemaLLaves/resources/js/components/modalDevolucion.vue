<template>
    <div class="capa-cebolla">
        <div class="ventanaModal">
            <h3 class="titulo">objetos prestados</h3>
            <div class="devolucionInfo">
                <label style="text:blue">Maestro:</label>{{maestro}}<br>
                <label style="text:blue">Materia:</label> {{materia}}
            </div>
            <div class="contentListado">
                <div v-for="objetos in listado" :key="objetos['id_control']" class="listado">
                    <label :for="objetos">{{objetos['nombre']}}</label>
                    <input type="checkbox" :id="objetos['id_control']" v-model="objetosDevueltos" :value="objetos['id_objeto']"><br>
                </div>
            </div>
            <div class="opciones">
                <slot></slot>
            </div>
        </div>
    </div>
</template>

<style>
    .devolucionInfo{
        text-align: left;
        font-size: 18px;
        display: inline-block;
    }

    .devolucionInfo label{
        color: #004990;
        font-weight: bold;
        font-family: Montserrat;
    }

    .capa-cebolla{
        position: fixed;
        z-index: 1;
        background-color: rgba(0, 0, 0,.5);
        height: 100%;
        width: 100%;
        display:flex;
        top: 0;
        bottom: 100%;
    }
    .ventanaModal{
        height: 80vh;
        width: 500px;
        margin: auto;
        border-radius: 5px;
        position: relative;
        align-items: center;
        background: white;
        z-index: 3;
        overflow: auto;
        text-align: center;
        flex-direction: column;
        border: 2px solid grey;
    }
    .titulo{
        font-family: Montserrat,sans-serif;
        border-bottom: 2px solid #004990;
        font-weight: 500;
        font-size: 1.7rem;
        margin: 0%;
        padding: 5%;
    }
    .contentListado{
        height: 75%;
    }
    .listado{
        display: grid;
        align-items: center;
        font-weight: lighter;
        font-size: 1.7rem;
        grid-template-columns: repeat(2,1fr);

    }
    .listado input{
        border-radius: 9px;
    }

    .botonFin{
        border-radius: 50px;
        width: 30%;
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
        width: 30%;
        background: white;
        font-size: 70%;
        align-self: center;
        margin: auto;
        height: 30px;
    }

    .opciones{
        /*vertical-align: bottom;*/
        display: flex;
        /*align-items: flex-start;*/
        /*justify-content: space-around;*/
        /*grid-template-columns: repeat(2,1fr);*/
        font-size: 0.7em;
    }
</style>

<script>
export default {
    data(){
        return {
            listado:this.objetos,
            objetosDevueltos:[],
            maestro:this.maestro,
            materia:this.materia
        }
    },
    props:[
        'objetos',
        'hora',
        'idRegistro',
        'idPrestamo',
        'maestro',
        'materia'
    ],
    methods:{
        hacerDevolucion(){
            let cadenaObjetos=this.objetosDevueltos.join();
            
            axios.post('/api/devolucion',{'idRegistro':this.idRegistro,'horaDevolucion':this.hora,'idPrestamos':this.idPrestamo,'objDevueltos':cadenaObjetos})
            .then((res)=>{
                alert("devolucion realizada");
                /*if (res.data){
                    alert("devolucion realizada");
                }else{
                    console.log(res);
                }*/
            })
            .catch(()=>{
                alert('sucedio un error');
            });
        },
        cancelar(){
            this.objetos,this.hora,this.idRegistro,this.idPrestamo=null;
        }
    }
}
</script>

