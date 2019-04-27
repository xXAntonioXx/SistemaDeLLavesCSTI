<template>
    <div class="capa-cebolla1">
        <div class="ventanaModal1">
            <h2>Hello world</h2>
        </div>
    </div>
</template>
<style>
.capa-cebolla1{
    position: fixed;
    z-index: 1;
    background-color: rgba(0, 0, 0,.5);
    height: 100%;
    width: 100%;
    display:flex;
    top: 0;
    left: 0;
    bottom: 100%;
}
.ventanaModal1{
        height: 80vh;
        width: 500px;
        margin: auto;
        border-radius: 5px;
        position: relative;
        align-items: center;
        background: white;
        z-index: 3;
        overflow: auto;
        text-align: center;
        flex-direction: column;
        border: 2px solid grey;

        display: grid;
        grid-template-rows: 10% 20% 60% 10%;
        align-content: space-evenly;
    }
</style>
<script>
export default {
    
}
</script>

