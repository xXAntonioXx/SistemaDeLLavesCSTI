<template>
    <div class="divContenedor">
        <h3 class="userTitle">Llaves:</h3>
        <ul class="lista_users">
            <li class="colHead">
                <i>Id</i><i>Llave</i><i>N.Aula</i><i>Aula</i>
            </li>
            <div class="colContent">
              <li v-for="llave in llaves" :key="llave['id']" class="card_llaves">
                  <i>{{llave['id']}}</i>
                  <i>{{llave['codigo']}}</i> 
                  <i>{{llave['numero']}}</i>
                  <i>{{llave['aula']}}</i>
              </li>
            </div>
        </ul>

        <a href="#" class="agregar-csv" @click="openUserEdit('mario',1,1)">Cargar desde csv</a>
        <userModal ref="modalLoadLlaves" v-if="openModalLlave">
            <input type="button" value="Aceptar" class="botonFin" @click="subirArchivo()">
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
    .agregar-csv{
      font-size: 0.6em;
      align-self: flex-start;
      margin-left: 5%;
      margin-top: 5px;

    }
    .colHead{
        display: grid;
        grid-template-columns: 0.5fr 1fr 1fr 1.5fr;
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
import userModal from './modalLlaves';

export default {
    data(){
        return{
            llaves:{},
            openModalLlave:false,
        }
    },
    created(){
        this.fetchLlaves();
    },
    components:{
        userModal
    }
    ,
    methods:{
        fetchLlaves(){
            axios.get('/api/obtenerLlaves')
            .then(data=>this.llaves=data['data']);
        },
        openUserEdit(nombre,id,rol){
            this.openModalLlave=true;
        },
        cerrarModal(){
            this.openModalLlave=false;
        },
        subirArchivo(){
            this.$refs.modalLoadLlaves.addLlaves((response)=>{
              
              toast.fire({
                icon: (response.status==200)? 'success':'error',
                title: response.data.message
              })
              if(response.status==200){
                this.cerrarModal();
                this.fetchLlaves();
              }
            });
        },
        
    }
}
</script>

