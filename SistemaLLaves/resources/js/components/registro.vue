<template>
    <section class="llaves-prestadas">
      <h2>Llaves prestadas</h2>
      <div class="division"></div>
      <div class="llaves-titles">
        <h3>ID</h3>
        <h3>MAESTRO</h3>
        <h3>MATERIA</h3>
        <h3>SALON</h3>
        <h3>HORA</h3>
      </div>
      <div class="division"></div>
      <div class="llaves-cards">
        <div v-for="registro in pruebas" class="card-item">
            <h3>{{registro['id']}}</h3>
            <h3>{{registro['maestro']}}</h3>
            <h3>{{registro['materia']}}</h3>
            <h3>{{registro['aula']}}</h3>
            <h3>{{registro['hora']}}</h3>
        </div>
        <!--div class="card-item">
          <h3>2</h3>
          <h3>Ciret</h3>
          <h3>Estructura</h3>
          <h3>5j-205</h3>
          <h3>12:00</h3>
        </div-->
      </div>
      <div class="llaves-paginador">
        <ul>
          <li><a>1</a></li>
          <li><a>2</a></li>
          <li><a>3</a></li>
          <li><a>4</a></li>
          <li><a>5</a></li>
        </ul>
      </div>
    </section>
</template>

<style scoped src="./css/principal.css">	
</style>

<script>
export default {
    data(){
        return{
            pruebas:[
                {id:'1',maestro:'Cirett',materia:'Estructura de Datos',aula:'5j-201',hora:'12:00'},
                {id:'2',maestro:'Alvaro',materia:'Inteligencia Artificial',aula:'5g-201',hora:'14:00'},
                {id:'3',maestro:'Raquel',materia:'Mineria de Datos',aula:'5j-203',hora:'09:00'}
            ],
        }
    }
}
</script>
