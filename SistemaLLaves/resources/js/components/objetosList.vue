<template>
  <div class="inventory-container">
    <div class="inventory-title-section">
      <h2>OBJETOS PARA PRÉSTAMO</h2>
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
          <input type="checkbox" id="inventory-item-check" :key="'inventory-item-check-'+objeto['id']" v-bind:value="'object-'+objeto['id']" v-model="objectsDelete">
          <h4 id="inventory-item-id" :key="'inventory-item-id-'+objeto['id']" @click="openObjectEdit(objeto['id'],objeto['nombre'],objeto['marca'],objeto['descripcion'],objeto['inventario'])">{{objeto['id']}}</h4>
          <h4 id="inventory-item-object" :key="'inventory-item-object-'+objeto['id']" @click="openObjectEdit(objeto['id'],objeto['nombre'],objeto['marca'],objeto['descripcion'],objeto['inventario'])">{{objeto['nombre']}}</h4>
          <h4 id="inventory-item-brand" :key="'inventory-item-brand-'+objeto['id']" @click="openObjectEdit(objeto['id'],objeto['nombre'],objeto['marca'],objeto['descripcion'],objeto['inventario'])">{{objeto['marca']}}</h4>
          <h4 id="inventory-item-description" :key="'inventory-item-description-'+objeto['id']" @click="openObjectEdit(objeto['id'],objeto['nombre'],objeto['marca'],objeto['descripcion'],objeto['inventario'])">{{(objeto['descripcion'].length <35) ? objeto['descripcion'] : (objeto['descripcion'].substring(0,35)+'...')}}</h4>
          <h4 id="inventory-item-quantity" :key="'inventory-item-quantity-'+objeto['id']" @click="openObjectEdit(objeto['id'],objeto['nombre'],objeto['marca'],objeto['descripcion'],objeto['inventario'])">{{objeto['inventario']}}</h4>
        </div>
      </div>
    </div>

    <div class="inventory-buttons">
      <input type="submit" value="Eliminar" class="inventory-button-delete" @click="deleteObjetcs()">
      <input type="submit" value="Agregar" class="inventory-button-add" @click="openObjectModal('Agregar')">
    </div>

    <objectModal ref="modalUpdateObjects" v-if="openModalObject" 
      :propAccionRealizar="this.accionRealizar" 
      :propIdObjeto="this.idObjeto" 
      :propNombre="this.nombreObjeto" 
      :propMarca="this.marcaObjeto"
      :propDescripcion="this.descObjeto" 
      :propInventario="this.invObjeto"
      >
            <input type="button" value="Aceptar" class="botonFin" @click="save()">
            <input type="submit" value="Cancelar" class="botonCancelar" @click="cerrarModal()" />
    </objectModal>

    <deleteObjectModal ref="modalDeleteObject" v-if="openModalDeleteObject" :propObjectsString="this.objectsString">
      <input type="button" value="Aceptar" class="botonFin" @click="confirmDelete()">
      <input type="submit" value="Cancelar" class="botonCancelar" @click="cerrarDeleteModal()" />
    </deleteObjectModal>
  </div>
</template>

<script>
import objectModal from './modalObjetos';
import deleteObjectModal from './modalEliminarObjects';
export default {
  data(){
    return {
      objetos:{},
      objectsDelete:[],
      openModalObject:false,
      openModalDeleteObject:false,
      idObjeto:null,
      accionRealizar:'',
      nombreObjeto:'',
      marcaObjeto:'',
      descObjeto:'',
      invObjeto:0,
      objectsString:''
    }
  },
  components:{
    objectModal,
    deleteObjectModal
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
      if(this.accionRealizar=='Agregar') {
        this.openModalObject=true;
      }
    },
    openObjectEdit(id,nombre,marca,descripcion,inventario) {
      this.accionRealizar='Modificar'
      this.idObjeto=id;
      this.nombreObjeto=nombre;
      this.marcaObjeto=marca;
      this.descObjeto=descripcion;
      this.invObjeto=inventario;
      this.openModalObject=true;
    },
    cerrarModal(){
      this.openModalObject=false;
      this.idObjeto=null;
      this.nombreObjeto='';
      this.marcaObjeto='';
      this.descObjeto='';
      this.invObjeto=0;
    },
    cerrarDeleteModal(){
      this.openModalDeleteObject=false;
    },
    confirmDelete(){
      this.$refs.modalDeleteObject.saveChanges((response)=>{
        toast.fire({
          icon: (response.status==200)? 'success':'error',
          title: response.data.message
        });
        if(response.status==200){
          this.fetchObjetos();
          this.cerrarDeleteModal();
          this.objectsString='';
          this.objectsDelete=[];
        }
      });
    },
    deleteObjetcs(){
      if(this.objectsDelete.length>0){
        let eliminar='';
        this.objectsDelete.forEach(element => {
          eliminar+=element.substring(7,element.length)+",";
        });
        this.objectsString=eliminar.substring(0,eliminar.length-1);
        this.openModalDeleteObject=true;
      }else{
        toast.fire({
          icon: 'error',
          title: 'No hay objetos seleccionados'
        })
      }
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