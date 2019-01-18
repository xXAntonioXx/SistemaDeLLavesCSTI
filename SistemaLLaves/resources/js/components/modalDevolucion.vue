<template>
    <div class="capa-cebolla">
        <div class="ventanaModal">
            <div class="tituloDiv">
                <h3 class="titulo">objetos prestados</h3>
            </div>
            <div class="devolucionInfo">
                <label style="text:blue">Maestro:</label>{{maestro}}<br>
                <label style="text:blue">Materia:</label> {{materia}}<br>
                <label>Aula:</label>{{Aula}}
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
        margin: auto;
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

        display: grid;
        grid-template-rows: 10% 20% 60% 10%;
        align-content: space-evenly;
    }
    @media screen and (max-width:600px) and (max-height:480px){
        .ventanaModal{
            height: 500px;
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

            display: grid;
            grid-template-rows: 10% 30% 50% 10%;
            align-content: space-evenly;
        }
    }
    @media screen and (max-height:490px) and (orientation: landscape) and (min-width: 610px){
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

            display: grid;
            grid-template-rows: 40px 120px 200px 40px;
            align-content: space-evenly;

            overflow-y: scroll;
        }
    }
    .titulo{
        font-family: Montserrat,sans-serif;
        font-weight: 500;
        font-size: 1.7rem;
        margin: auto;
        height: 100%;
    }
    .contentListado{
        height: 100%;
        overflow-y: scroll;
    }
    .listado{
        display: grid;
        align-items: center;
        font-weight: inherit;
        font-size: 1.2rem;
        grid-template-columns: repeat(2,1fr);
        text-align: left;
        margin-left: 50px;
    }
    .listado input{
        margin: auto;
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
        position: absolute;
        bottom: 0;
        margin-bottom: 5%;
        width: 100%;
        /*align-items: flex-start;*/
        /*justify-content: space-around;*/
        /*grid-template-columns: repeat(2,1fr);*/
        font-size: 0.7em;
    }
    .tituloDiv{
        border-bottom: 2px solid #004990;
        height: 100%;
    }
</style>

<script>
export default {
    data(){
        return {
            listado:this.objetos,
            objetosDevueltos:[],
            PrestamoID:this.idPrestamo,
            Maestro:this.maestro,
            Materia:this.materia,
            Aula:this.aula
        }
    },
    props:[
        'objetos',
        'hora',
        'idRegistro',
        'idPrestamo',
        'maestro',
        'materia',
        'aula'
    ],
    methods:{
        hacerDevolucion(){
            let cadenaObjetos=this.objetosDevueltos.join();
            console.log(this.idRegistro +"*"+this.hora +"*"+this.PrestamoID+"*"+cadenaObjetos);
            axios.post('/api/devolucion',{'idRegistro':this.idRegistro,'horaDevolucion':this.hora,'idPrestamos':this.PrestamoID,'objDevueltos':cadenaObjetos})
            .then((res)=>{
                alert("devolucion realizada");
            })
            .catch(()=>{
                console.error('sucedio un error');
            });
        },
        cancelar(){
            this.objetos,this.hora,this.idRegistro,this.PrestamoID,this.Aula=null;
        }
    }
}
</script>

