<template>
    <div class="capa-cebolla1">
        <div class="ventanaModal1">
            <h4 style="margin-left:30px">Editar usuario "{{this.nombre}}"</h4>
            <div class="formEdit">
                <label for="nuevoNombre">Cambiar nombre:</label><br>
                <input id="nuevoNombre" type="text"><br>
                <label for="nuevaContra1">Cambiar contraseña:</label><br>
                <input id="nuevaContra1" type="text"><br>
                <label for="nuevaContra2">Nueva contraseña:</label><br>
                <input id="nuevaContra2" type="text"><br>
                <select name="rol" id="rol" class="dropdown">
                    <option>Permisos...</option>
                    <option value="1">Admin</option>
                    <option value="2">Secretari@</option>
                </select>
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
    margin-left:20px; 
}
.formEdit label{
    font-size:0.7em; 
}
.formEdit input{
    width: 300px;
    height: 35px;
    background: #E8E8E8;
    border: none;
    font-size: 1em;
    margin-bottom: 0.5em;
}
.botonFin{
    border-radius: 50px;
    width: 40%;
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
    width: 40%;
    background: white;
    font-size: 70%;
    align-self: center;
    margin: auto;
    height: 30px;
}
.opcionesB{
    display: grid;
    grid-template-columns: 1fr 1fr;
}
</style>
<script>
export default {
    data(){
        return{
            nombre:this.nombreUsuario,
            id:this.idUsuario
        }
    },
    props:[
        'nombreUsuario',
        'idUsuario'
    ]
}
</script>

