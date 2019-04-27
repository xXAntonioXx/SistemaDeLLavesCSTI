<template>
    <div class="divContenedor">
        <h3 class="userTitle">Usuarios:</h3>
        <ul class="lista_users">
            <li class="colHead">
                <i>id</i><i>nombre</i><i>rol</i><i>estado</i>
            </li>
            <li v-for="user in usuarios" :key="user['id']" class="card_user" @click="openUserEdit()">
                <i>{{user['id']}}</i>
                <i>{{user['nombre']}}</i> 
                <i>{{user['rol']}}</i>
                <i>{{user['estado']}}</i>
            </li>
        </ul>
        <userModal v-if="openModalUser">

        </userModal>
    </div>
</template>
<style>
    .divContenedor{
        height: 100%;
    }
    .colHead{
        display: grid;
        grid-template-columns: 1fr 1fr 1fr 1fr;
        height: 35px;
        background: #004990;
        color: white;
        font-size: 0.6em;
        width: 100%;
    }
    .colHead i{
        width: 80%;
        margin-left: 20%;
        font-style: normal;
    }
    .userTitle{
        width: 100%;
        text-align: center;
        font-size: 0.7em;
    }
</style>

<script>
import userModal from './userModal';

export default {
    data(){
        return{
            usuarios:{},
            openModalUser:false
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
        openUserEdit(){
            this.openModalUser=true;
        }
    }
}
</script>

