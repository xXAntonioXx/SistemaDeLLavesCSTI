<template>
  <div class="inventory-container">
    <div class="inventory-title-section">
      <h2>OBJETOS PARA PRESTAMO</h2>
    </div>
    <div class="inventory">
      <div class="inventory-titles">
        <h3 id="inventory-title-id">ID</h3>
        <h3 id="inventory-title-object">OBJETO</h3>
        <h3 id="inventory-title-brand">MARCA</h3>
        <h3 id="inventory-title-description">DESCRIPCIÓN</h3>
        <h3 id="inventory-title-quantity">CANTIDAD</h3>
      </div>
      <div class="inventory-items">
        <div v-for="objeto in objetos" :key="objeto['id']" class="inventory-item">
          <input type="checkbox" id="inventory-item-check">
          <h4 id="inventory-item-id">{{objeto['id']}}</h4>
          <h4 id="inventory-item-object">{{objeto['nombre']}}</h4>
          <h4 id="inventory-item-brand">{{objeto['marca']}}</h4>
          <h4 id="inventory-item-description">{{objeto['descripcion']}}</h4>
          <h4 id="inventory-item-quantity">{{objeto['inventario']}}</h4>
        </div>
      </div>
    </div>

    <div class="inventory-buttons">
      <input type="submit" value="Eliminar" class="inventory-button-delete" @click="openObjectModal('Agregar')">
      <input type="submit" value="Editar" class="inventory-button-edit" @click="openObjectModal('Modificar')">
      <input type="submit" value="Agregar" class="inventory-button-add" @click="openObjectModal('Agregar')">
    </div>

    <objectModal ref="modalUpdateObjects" v-if="openModalObject" :propAccionRealizar="this.accionRealizar">
            <input type="button" value="Aceptar" class="botonFin" @click="save()">
            <input type="submit" value="Cancelar" class="botonCancelar" @click="cerrarModal()" />
    </objectModal>
  </div>
</template>

<script>
import objectModal from './modalObjetos';
export default {
  data(){
    return {
      objetos:{},
      openModalObject:false,
      accionRealizar:'',
    }
  },
  components:{
    objectModal
  },
  created(){
      this.fetchObjetos();
  },
  methods:{
    fetchObjetos(){
      axios.get('/api/obtenerObjetos')
      .then(data=>{
        this.objetos=data['data'];
      });
    },
    openObjectModal(action){
      this.accionRealizar=action;
      if(this.accionRealizar=='Agregar' || this.accionRealizar=='Modificar') {
        this.openModalObject=true;
      }
    },
    cerrarModal(){
      this.openModalObject=false;
    },
    save(){
      this.$refs.modalUpdateObjects.saveChanges((response)=>{
          toast.fire({
            icon: (response.status==200)? 'success':'error',
            title: response.data.message
          })
          if(response.status==200){
            this.fetchObjetos();
            this.cerrarModal();
          }
      });

      
    }

  }
}
</script>