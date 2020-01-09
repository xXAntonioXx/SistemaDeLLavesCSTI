<template>
  <div class="twoColBody">
    <section class="left-content">
      <div class="section-title">
        <h2>Registrar Usuario</h2>
      </div>
      <form  class="newUserForm" method="POST">
        <input type="hidden" name="_token" v-model="token"/>
        <strong>Nombre del Usuario</strong> <br>
        <input class="inp" id="NewUserName" v-model="userName" name="NewUserName" type="text" placeholder=" Cualquier nombre funciona">
        <br>
        <strong>Contraseña</strong><br>
        <input class="inp" id="NewUserPass" v-model="userPass" name="NewUserPass" type="password" placeholder=" Cualquier contraseña funciona">
        <br>
        <strong> Confirmar Contraseña</strong><br>
        <input class="inp" id="confirmPass" v-model="userConfPass" name="confirmPass" type="password" placeholder=" Repite la contraseña">
        <br>
        <select name="rol" id="rol" class="dropdown" v-model="rol">
            <option value="0" disabled>Permisos...</option>
            <option value="1">Admin</option>
            <option value="2">Secretari@</option>
        </select>
        <br>
        <div class="opcionesB">
          <input type="button" value="Aceptar" class="botonFin" @click="registrarUsuario()">
          <input type="button" value="Cancelar" class="botonCancelar" @click="limpiarRegistroUsuario()" />
        </div>
      </form>
    </section>

    

    <section class="right-content">
        <usuarios ref="usersList"></usuarios>
    </section>
    <!-- <input class="submitBtn" type="submit" value="Agregar"> -->
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
      userName:'',
      userPass:'',
      userConfPass:'',
      rol:'0',
    }
  },
  created(){
    this.getToken()
  },
  methods:{
    getToken(){
      this.token=document.getElementsByName('csrf-token')[0].getAttribute('content');
      console.log(this.token);
    },
    registrarUsuario(){
      if(this.userName=='' || this.userPass=='' || this.userConfPass=='' || this.rol==0) {
        toast.fire({
            icon:'error',
            title: 'Alguno de los campos se encuentra vacío.'
          })
          return;
      }
      if(this.userPass==this.userConfPass){
        console.log('iguales');
        axios.post('/api/AgregarUsuario',{'NewUserName':this.userName, 'userPass':this.userPass,'rol':this.rol})
        .then(response=>{
          toast.fire({
            icon: (response.status==200)? 'success':'error',
            title: response.data.message
          })
          if(response.status==200){
            this.limpiarRegistroUsuario();
            this.$refs.usersList.fetchUsuarios();
          }
        })
        .catch(error=>{
          toast.fire({
            icon:'error',
            title: error.response.data.message
          })
        });
      }else{
        toast.fire({
            icon:'error',
            title: 'Las contraseñas no coinciden.'
          })
      }
      
    },
    limpiarRegistroUsuario(){
      this.userName='';
      this.userPass='';
      this.userConfPass='';
      this.rol=0;
    }
  }
}
</script>