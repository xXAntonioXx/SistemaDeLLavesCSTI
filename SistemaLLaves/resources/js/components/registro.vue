<template>
<div class="body-container">
    <section class="llaves-prestadas">
      <h2 class="llaves-prestadas-tittle">Llaves prestadas</h2>
      <!--div class="division"></div-->
      <div class="llaves-titles">
        <h3>No#</h3>
        <h3>MAESTRO</h3>
        <h3>MATERIA</h3>
        <h3>SALÓN</h3>
        <h3>HORA</h3>
      </div>
      <div class="llaves-cards">
        <div v-for="registro in Paginate" class="card-item" :key="registro['id']" :title="registro['salon']+'\n'+registro['maestro']+'\n'+registro['materia']">
            <h3>{{registro['numero']}}</h3>
            <h3>{{registro['maestro']}}</h3>
            <h3>{{registro['materia']}}</h3>
            <h3>{{registro['salon']}}</h3>
            <h3>{{ registro['hora_entrada'].split(" ")[1] }}</h3>
        </div>
      </div>
      <div class="llaves-paginador">
        <ul>
          <li v-for="n in paginas" :key="n">
            <a @click="getPages(n)">{{n}}</a>
          </li>
        </ul>
      </div>
    </section>
    <section class="formulario-prestamo">
      <div class="formulario-tittle">
          <h2>Formulario de préstamo</h2>
          <div class="ghost-div"></div>
      </div>
      <div class="formulario-wrapper">
        <form action="" class="formulario-prestamo-content">
          <h3 class="llaves">No. Llave</h3>
          <h3 class="maestros">Maestro</h3>
          <h3 class="materia">Materia</h3>
          <h3 class="aula">Aula</h3>
          <h3 class="hora">Hora</h3>
          <select class="combo-box inputs" @change="formularioParaExcepcion()" disabled>
            <option value="Rivera Samudio">Rivera Samudio</option>
            <option value="Lab-IQ">Lab-IQ</option>
            <option value="Lab-Mecatronica">Lab-Mecatronica</option>
          </select>
            <input @keyup.enter="PrestamoOdevolucion(codigoKey)" class="llaves-i inputs" type="text" v-model="codigoKey">
            <input class="maestros-i inputs" type="text" v-model="registroForm['maestro']" :disabled="validate=estadoInput">
            <input class="materia-i inputs" type="text" v-model="registroForm['materia']" :disabled="validate=estadoInput">
            <input class="aula-i inputs" type="text" v-model="registroForm['aula']" :disabled="validate=estadoInput">
            <input class="hora-i inputs" type="text" v-model="registroForm['hora']" :disabled="validate=estadoInput">
        </form>
      </div>

      <div class="button-registro">
          <input type="submit" value="Registrar" class="registrar"  onclick="window.location='#modal-container'" :disabled="validated=RegistrarState"/>
          <input type="submit" value="Cancelar" class="cancelar" @click="cleanObjPrestamo()"/>
      </div>
      <div id="modal-container" class="modal-container" >
        <div class="modal-content">
          <h3 class="modal-tittle">Lista de articulos</h3>
          <div class="modal-list">
            <select class="combo-box" name="modal-article-list" id="modal-article-list" v-for="comboInd in comboIterates" @change="agregarCombo(comboInd,comboInd['valor'])" :key="comboInd['id']" v-model="comboInd['valor']" :disabled="validate=comboInd['estado']" :value="null">
              <option v-for="objects in comboInd['ObjetosDisponibles']" :value="objects.id" :key="objects['id']">
                {{objects['nombre']+"("+objects['marca']+")"}}
              </option>
            </select>
          </div>
          <div class="modal-buttons">
            <input type="button" value="Aceptar" class="modal-button-aceptar" v-on:click="NuevoRegistro()" onclick="window.location='#';">
            <input type="button" value="Cancelar" class="modal-button-cancelar" onclick="window.location='#';" @click="comboIterates=[{id:1,estado:false,valor:'0',ObjetosDisponibles:ObjetosCombo}];PrestamoList=''">
          </div>
        </div>
      </div>
    </section>
        <modalDevolucion v-if="esDevolucion" v-bind:objetos="objeto" ref="ventanaDevolucion" :hora="showTime(1)" :idRegistro="this.idRegistroExistente" :idPrestamo="this.idPrestamoRegistrado" :maestro="maestroDevolucion" :materia="materiaDevolucion" :aula="aulaDevolucion" :llave="llaveDevolucion">
          <input type="button" value="Aceptar" class="botonFin" @click="devolucion();esDevolucion=false">
          <input type="submit" value="Cancelar" class="botonCancelar" @click="cancelarDevolucion()" />
        </modalDevolucion>
    </div>
</template>

<style scoped src="../../../public/css/principal.css">	
</style>

<script>
import moment from 'moment-timezone';
import modalDevolucion from './modalDevolucion';

export default {
    data(){
        return{
            Pages:[],
            indicePagina:1,
            paginas:1,
            codigoKey:'',
            registroForm:[],
            estadoInput:true,
            ObjetosCombo:[],
            comboIterates:[],
            PrestamoList:"",
            globalTime:'0',
            RegistrarState:true,
            esDevolucion:false,
            objeto:[],
            idRegistroExistente:'',
            idPrestamoRegistrado:'',
            maestroDevolucion:'',
            materiaDevolucion:'',
            aulaDevolucion:'',
            llaveDevolucion:''
        }
    },
    components:{
      modalDevolucion,
    },
    created(){
      this.fetchRegistros();
      this.ObtenerObjetosDisponiblesInventario();
    },
    computed:{
      Paginate(){
        return this.Pages.slice(7*(this.indicePagina-1),7*this.indicePagina);
      },
      
    },
    methods:{
      fetchRegistros(){//metodo para traer todos los registros del dia
        axios.get('api/registros')
        .then(data=>{
          this.paginas=Math.ceil(data['data'].length/7);
          this.Pages=data['data'].reverse();
        });
      },
      ObtenerObjetosDisponiblesInventario(){
        let ruta = "api/ObjetosInventario";
        axios.get(ruta).then(res=>{
          this.ObjetosCombo=res.data;
          this.comboIterates.push({
              id:1,
              estado:false,
              valor:'0',
              ObjetosDisponibles:this.ObjetosCombo
          });
        });
      },
      getPages(nPage){//obtener cantidad n de paginas
        this.indicePagina=nPage;
      },

      showTime(caso=1){//obtenemos la hora actual fechaHora=(fecha/hora) hora=(hora)
        let timez = moment.tz.guess();
        let FechaHora = moment.tz(timez).format("YYYY-M-D HH:mm:ss");
        let hora=moment.tz(timez).format("HH:mm:ss");
        return caso==1?FechaHora:hora;
      },

      PrestamoOdevolucion(codigoLLave){
        let consulta = `api/devolucionOprestamo/${codigoLLave}`;
        axios.get(consulta).then(res=>{
          let nuevo=res.data['id'];
          let resultado = res.data['id_prestamo'];
          if (nuevo == 0){
            this.buscarHorario(codigoLLave);
          }else{
            this.maestroDevolucion=res.data['nombre'];
            this.materiaDevolucion=res.data['materia'];
            this.aulaDevolucion=res.data['aula'];
            this.llaveDevolucion=codigoLLave;
            let ruta = `api/obtenerObjetos/${resultado}`;
            axios.get(ruta).then(res=>{
              this.objeto=res.data;
              this.esDevolucion=true;
              this.idRegistroExistente=nuevo;
              this.idPrestamoRegistrado=resultado;
            })
            .catch(()=>{
              this.objeto=[];
              this.esDevolucion=true;
              this.idRegistroExistente=nuevo;
              this.idPrestamoRegistrado="NULL";
            });
          }
        });
      },

      devolucion(){
        this.$refs.ventanaDevolucion.hacerDevolucion((response)=>{
          
          if(response.status==200){
            toast.fire({
              icon: 'success',
              title: 'Devolución registrada'
            });
            this.fetchRegistros();
            this.codigoKey='';
          } else {
            toast.fire({
              icon: 'error',
              title: 'Ups! Ocurrio un error.'
            });
          }
        });
      },
      cancelarDevolucion(){
        this.$refs.ventanaDevolucion.cancelar();
        this.esDevolucion=false;
        this.codigoKey='';
      },

      buscarHorario(codigoLLave){//obtenemos id,maestro,materia,aula con el codigo de llave
        let time=this.showTime();
        this.globalTime=time;
        this.codigoKey=codigoLLave;
        let busqueda = `api/buscarHorario/${codigoLLave}/${time}`;
        axios.get(busqueda)
        .then(res=>{
          if(res.data){
            this.registroForm=res.data;
            this.registroForm['hora']=this.showTime(2);
            this.RegistrarState=false;
          }
        }).catch((res)=>{
        });
        
        this.estadoInput=true;
      },

      agregarCombo(identificador,objeto){//deshabilitamos el combo seleccionado y generamos un nuevo combo
        if(this.comboIterates.length<4){
          this.PrestamoList+=objeto+',';
          let customObj = this.ObjetosCombo.filter((item)=>{
            return !this.PrestamoList.includes(item.id);
          });
          this.comboIterates.push({id:identificador['id']+1,valor:'0',estado:false,ObjetosDisponibles:customObj});
        }else if(this.comboIterates.length==4){
          this.PrestamoList+=objeto+',';
        }
          identificador["estado"]=true;
      },

      formularioParaExcepcion(){//limpiamos todo el formulario(posiblemente hay que eliminar)
        this.registroForm=[];
        this.estadoInput=false;
        this.codigoKey='';
      },

      cleanObjPrestamo(){//limpiamos el formulario despues de generar un registro
        this.comboIterates=[{id:1,estado:false,valor:'0',ObjetosDisponibles:this.ObjetosCombo}];
        this.registroForm=[];
        this.codigoKey='';
        this.RegistrarState=true;
        this.PrestamoList='';
      },

      NuevoRegistro(){//se genera un nuevo registro y recarga todos los registros en el area derecha y limpia el formulario
        console.log(this.codigoKey+"  "+this.globalTime+"  "+this.registroForm['id']+"  "+this.PrestamoList.slice(0,-1));
        axios.post('/api/nuevoRegistro',{'llave':this.codigoKey,'fechaHora':this.globalTime,'idHorario':this.registroForm['id'],'objList':this.PrestamoList.slice(0,-1)})
        .then((res)=>{
          toast.fire({
            icon:'success',
            title: 'Préstamo registrado.'
          });
          this.fetchRegistros();
          this.cleanObjPrestamo();
        });
      },
    }
}
</script>
