
/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');


import swal from 'sweetalert2';
window.swal = swal;

const toast = swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000,
    timerProgressBar: true,
    onOpen: (toast) => {
        toast.addEventListener('mouseenter', swal.stopTimer)
        toast.addEventListener('mouseleave', swal.resumeTimer)
    }
})

window.toast = toast;
/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

Vue.component(
    'registro', 
    require('./components/registro.vue')
);

Vue.component(
    'busqueda',
    require('./components/Busqueda.vue')
);

Vue.component(
    'usuarios',
    require('./components/usuariosList.vue')
);

Vue.component(
    'registrousuario',
    require('./components/registrarUsuario.vue')
);

Vue.component(
    'llaves',
    require('./components/llavesList.vue')
)

const app = new Vue({
    el: '#app',
});
