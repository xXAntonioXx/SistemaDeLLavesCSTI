<template>
  <div class="inventory-container">
    <div class="inventory-title-section">
      <h2>ÚLTIMOS REPORTES</h2>
    </div>
    <div class="inventory">
      <div class="inventory-titles">
        <h3 id="inventory-title-id">ID</h3>
        <h3 id="inventory-title-object">FECHA</h3>
        <h3 id="inventory-title-brand">AULA</h3>
        <h3 id="inventory-title-description">DESCRIPCIÓN</h3>
        <h3 id="inventory-title-quantity">ESTATUS</h3>
      </div>
      <div class="inventory-items">
        <div v-for="objeto in reportes" :key="objeto['id']" class="inventory-item" :title="objeto['descripcion']">
          <input type="checkbox" id="inventory-item-check" :key="'inventory-item-check-'+objeto['id']" v-bind:value="'object-'+objeto['id']">
          <h4 id="inventory-item-id" :key="'inventory-item-id-'+objeto['id']">{{objeto['id']}}</h4>
          <h4 id="inventory-item-object" :key="'inventory-item-object-'+objeto['id']">{{objeto['fecha']}}</h4>
          <h4 id="inventory-item-brand" :key="'inventory-item-brand-'+objeto['id']">{{objeto['aula']}}</h4>
          <h4 id="inventory-item-description" :key="'inventory-item-description-'+objeto['id']">{{ (objeto['descripcion'].length <35) ? objeto['descripcion'] : (objeto['descripcion'].substring(0,35)+'...')}}</h4>
          <h4 id="inventory-item-quantity" :key="'inventory-item-quantity-'+objeto['id']">{{objeto['estatus']}}</h4>
        </div>
      </div>
    </div>

    <div class="inventory-buttons">
      <input type="submit" value="Agregar" class="inventory-button-add" @click="openReportModal('Registrar')">
    </div>

    <reportModal ref="modalUpdateObjects" v-if="openModalReporte" 
      :propAccionRealizar="this.accionRealizar" 
      :propDescripcion="this.descReporte" 
      :propAula="this.aula"
      >
            <input type="button" value="Aceptar" class="botonFin" @click="save()">
            <input type="submit" value="Cancelar" class="botonCancelar" @click="cerrarModal()" />
    </reportModal>
  </div>
</template>

<script>
import reportModal from './modalSoporte.vue';
export default {
  data(){
    return {
      reportes:{},
      openModalReporte:false,
      descReporte:'',
      aula:null
    }
  },
  components:{
    reportModal
  },
  created(){
      this.fetchReportes();
  },
  methods:{
    fetchReportes(){
      axios.get('/api/obtenerReportes')
      .then(data=>{
        this.reportes=data['data'];
      });
    },
    openReportModal(action){
      this.accionRealizar=action;
      if(this.accionRealizar=='Registrar') {
        this.openModalReporte=true;
      }
    },
    openReportEdit(id,descripcion) {
      this.accionRealizar='Modificar'
      this.aula=id;
      this.descReporte=descripcion;
      this.openModalReporte=true;
    },
    cerrarModal(){
      this.openModalReporte=false;
      this.aula=null;
      this.descReporte='';
    },
    save(){
      this.$refs.modalUpdateObjects.saveChanges((response)=>{
          toast.fire({
            icon: (response.status==200)? 'success':'error',
            title: response.data.message
          })
          if(response.status==200){
            this.fetchReportes();
            this.cerrarModal();
          }
      });

      
    }

  }
}
</script>