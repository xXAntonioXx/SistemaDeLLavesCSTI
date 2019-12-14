<template>
    <div class="divContenedor">
        <h3 class="userTitle">Usuarios:</h3>
        <ul class="lista_users">
            <li class="colHead">
                <i>id</i><i>nombre</i><i>rol</i><i>estado</i>
            </li>
            <li v-for="user in usuarios" :key="user['id']" class="card_user" @click="openUserEdit(user['nombre'],user['id'],user['rol'])">
                <i>{{user['id']}}</i>
                <i>{{user['nombre']}}</i> 
                <i>{{user['rol'] ==1 ? 'Admin':'Secretari@'}}</i>
                <i>{{user['estado']}}</i>
            </li>
        </ul>
        <userModal ref="modalUpdateUser" v-if="openModalUser" :nombreUsuario="this.usuarioNombreEditar" :idUsuario="this.usuarioIdEditar" :rol="this.usuarioRolEditar">
            <input type="button" value="Aceptar" class="botonFin" @click="hacerCambios()">
            <input type="submit" value="Cancelar" class="botonCancelar" @click="cerrarModal()" />
        </userModal>
    </div>
</template>
<style>
    .divContenedor{
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        height: 100%;
        width: 90%;
    }
    .colHead{
        display: grid;
        grid-template-columns: 1fr 1fr 1fr 1fr;
        height: 35px;
        background: #004990;
        color: white;
        border-radius: 5px 5px 0 0;
        font-size: 0.6em;
        width: 100%;
    }
    .colHead i{
        width: 80%;
        margin-left: 20%;
        font-style: normal;
    }
    .userTitle{
        width: 90%;
        text-align: center;
        font-size: 0.7em;
        margin: 0;
    }
</style>

<script>
import userModal from './userModal';

export default {
    data(){
        return{
            usuarios:{},
            openModalUser:false,
            usuarioNombreEditar:null,
            usuarioIdEditar:null,
            usuarioRolEditar:null
        }
    },
    created(){
        this.fetchUsuarios();
    },
    components:{
        userModal
    }
    ,
    methods:{
        fetchUsuarios(){
            axios.get('/api/obtenerUsuarios')
            .then(data=>this.usuarios=data['data']);
        },
        openUserEdit(nombre,id,rol){
            this.openModalUser=true;
            this.usuarioNombreEditar=nombre;
            this.usuarioIdEditar=id;
            this.usuarioRolEditar=rol;
        },
        cerrarModal(){
            this.openModalUser=false;
            this.usuarioNombreEditar=null;
            this.usuarioIdEditar=null;
            this.usuarioRolEditar=null;
        },
        hacerCambios(){
            this.$refs.modalUpdateUser.realizarCambios(()=>{
                console.log('registro exitoso');
                this.cerrarModal();
                this.fetchUsuarios();
            });
        }
    }
}
</script>

