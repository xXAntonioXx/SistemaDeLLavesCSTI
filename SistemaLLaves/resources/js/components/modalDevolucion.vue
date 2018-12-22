<template>
    <div class="capa-cebolla">
        <div class="ventanaModal">
            <h3 class="titulo">objetos prestados</h3>
            {{this.disparaMetodo}}
            <div v-for="objetos in listado" :key="objetos['id_control']" class="listado">
                <label :for="objetos">{{objetos['nombre']}}</label><input type="checkbox" :id="objetos['id_control']" v-model="objetosDevueltos"><br>
            </div>

            <slot class=""></slot>
        </div>
    </div>
</template>

<style>
    .capa-cebolla{
        position: absolute;
        z-index: 1;
        background-color: rgba(0, 0, 0,.5);
        height: 100%;
        width: 100%;
    }
    .ventanaModal{
        height: 80%;
        width: 30%;
        margin-left: 35%;
        margin-top: 3%;
        border-radius: 9px;
        font-family: Arial, Helvetica, sans-serif;
        position: absolute;
        background: white;
        z-index: 3;
        overflow: auto;
        text-align: center;
    }
    .titulo{
        border-bottom: 2px solid #004990;
        font-weight: 500;
        margin: 0%;
        padding: 5%;
    }
    .listado{
        display: grid;
        align-items: center;
        font-weight: lighter;
        grid-template-columns: repeat(2,1fr);
    }
    .listado input{
        border-radius: 9px;
    }

    .botonFin{
        border: 1px solid #004990;
        border-radius: 50px;
        width: 50%;
        height: 7%;
        background: white;
        font-size: 70%;
        margin-top: 70%;
    }
</style>

<script>
export default {
    data(){
        return {
            listado:this.objetos,
            disparaMetodo:this.activar,
            objetosDevueltos:[]
        }
    },
    props:[
        'objetos',
        'activar'
    ],
    watch:{
        disparaMetodo:function(){
            console.log("asdfasdf")
        }
    },
    methods:{
    }
}
</script>

