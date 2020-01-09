<template>
  <div class="twoColBody">
    <section class="left-content">
      <div class="section-title">
        <h2>Registrar llave</h2>
      </div>
      <form  class="newUserForm" method="POST">
        <input type="hidden" name="_token" v-model="token"/>
        <strong>Código de llave</strong> <br>
        <input class="inp" id="newcodigo" name="newcodigo" type="text" v-model="newcodigo" placeholder=" ej. 64477287912">
        <br>
        <strong>Numero de aula</strong><br>
        <input class="inp" id="newnumaula" name="newnumaula" type="text" v-model="newnumaula" placeholder=" ej. 23">
        <br>
        <strong>Área</strong><br>
        <input class="inp" id="newarea" name="newarea" type="text" v-model="newarea" placeholder=" ej. 5G">
        <br>
        <strong>Aula</strong><br>
        <input class="inp" id="newaula" name="newaula" type="text" v-model="newaula" placeholder=" ej. 204">
        <br>
        <div class="opcionesB">
          <input type="button" value="Aceptar" class="botonFin" @click="registrarLlave()">
          <input type="button" value="Cancelar" class="botonCancelar" @click="limpiarRegistroLlave()" />
        </div>
      </form>
    </section>

    <section class="right-content">
        <llaves ref="keysList"></llaves>
    </section>
  </div>
</template>

<style>
  .botonFin{
      border-radius: 50px;
      width: 80%;
      background: #004990;
      font-size: 70%;
      color: white;
      display: flex;
      justify-content: center;
      margin: auto;
      height: 35px;
  }
  .botonCancelar{
    border: 2px solid #004990;
    border-radius: 50px;
    width: 80%;
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
    return {
      token:'',
      newcodigo:'',
      newnumaula:'',
      newarea:'',
      newaula:''
    }
  },
  created(){
    this.getToken()
  },
  methods:{
    getToken(){
      this.token=document.getElementsByName('csrf-token')[0].getAttribute('content');
    },
    registrarLlave(){
      if(this.newcodigo=='' || this.newnumaula=='' || this.newarea=='' || this.newaula==0) {
        toast.fire({
            icon:'error',
            title: 'Alguno de los campos se encuentra vacío.'
          })
          return;
      }
      axios.post('/api/AgregarLlave',{'codigo':this.newcodigo, 'num':this.newnumaula,'area':this.newarea, 'aula':this.newaula})
      .then(response=>{
        toast.fire({
          icon: (response.status==200)? 'success':'error',
          title: response.data.message
        })
        if(response.status==200){
          this.limpiarRegistroLlave();
          this.$refs.keysList.fetchLlaves();
        }
      })
      .catch(error=>{
        toast.fire({
          icon:'error',
          title: error.response.data.message
        })
      });
      
    },
    limpiarRegistroLlave(){
      this.newcodigo='';
      this.newnumaula='';
      this.newarea='';
      this.newaula='';
    }
  }
}
</script>