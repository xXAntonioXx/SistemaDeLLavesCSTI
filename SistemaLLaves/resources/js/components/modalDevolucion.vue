<template>
    <div class="ventanaModal">
        <h3 class="titulo">objetos prestados</h3>
        
        <div v-for="objetos in listado" :key="objetos" class="listado">
            <label :for="objetos">{{objetos}}</label><input type="checkbox" :id="objetos" v-model="objetosDevueltos"><br>
        </div>
    </div>
</template>

<style>
    .ventanaModal{
        height: 80%;
        width: 30%;
        margin-left: 35%;
        margin-top: 3%;
        border: 1px solid black;
        border-radius: 9px;
        font-family: Arial, Helvetica, sans-serif;
        position: absolute;
        background: white;
        z-index: 1;
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

    /*.listado label{
        
        float: left;
    }*/
    .listado input{
        border-radius: 9px;
    }
</style>

<script>
export default {
    data(){
        return {
            listado:this.objetos,
            objetosDevueltos:[]
        }
    },
    props:[
        'objetos'
    ]
}
</script>

