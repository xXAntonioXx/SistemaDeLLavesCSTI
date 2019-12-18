<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
use App\Http\Middleware\adminCheckSess;
use App\Http\Middleware\CheckSess;
use App\Http\Middleware\alreadyStartSession;

Route::get('/wc', function () {
    return view('welcome');
});

//rutas y metodos para el login de usuario######################################################################

Route::get('/','LoginController@principal')->middleware(alreadyStartSession::class);
Route::post('/validate','LoginController@validar');//para validar el usuario en el login

Route::group(['middleware'=>'CheckSess'],function(){
################################################################################################################
//rutas para la pagina principal################################################################################

    Route::get('/main','PrincipalController@cargarRegistro');
    Route::get('/busqueda','BusquedaController@cargarBusqueda');

################################################################################################################
//rutas para el area de busqueda################################################################################

    Route::post('/busqueda_registros','BusquedaController@CargarRegistro');

################################################################################################################
//rutas para el area de soporte#################################################################################

    Route::post('/enviarObservacion','SoporteController@EnviarMail');

##############################################################################################################

    Route::get('/salir','LoginController@salir');//opcion de salir

    

################################################################################################################
//rutas para el area de inventario##############################################################################

    Route::get('/inventario','InventarioController@cargarInventario');//esta ruta llama a la vista del inventario


################################################################################################################
//rutas para el administrador##############################################################################

    Route::get('/panel','AdminController@Cargar');
    Route::get('/panel/nuevoUsuario','AdminController@NuevoUsuario');
    Route::get('/panel/cargarHorarios','AdminController@CargarHorarios');
    Route::get('/panel/cargarLlaves','AdminController@CargarLlaves');
    Route::post('/AgregarHorario','AdminController@AgregarHorario');


//API para consultar la base de datos###########################################################################


    Route::post('/api/nuevoPrestamo','ApisController@nuevoPrestamo');
    Route::post('/api/nuevoRegistro','ApisController@nuevoRegistro');
    Route::post('/api/devolucion','ApisController@hacerDevolucion');
    Route::get('/api/registros','ApisController@registrosNum');
    Route::get('/api/lap','ApisController@lap');
    Route::get('/api/buscarHorario/{codigo}/{hora}','ApisController@buscarHorario');
    Route::get('/api/devolucionOprestamo/{codigo}','ApisController@Devolucion_O_Prestamo');
    Route::get('api/obtenerObjetos/{idPrestamo}','ApisController@ObjetosPrestados');


    Route::get('api/ObjetosInventario','ApisController@ObjetosInventario');
});

Route::get('/api/obtenerUsuarios','ApisController@getUsuarios')->middleware(adminCheckSess::class);
Route::get('/api/obtenerLlaves','ApisController@getLlaves')->middleware(adminCheckSess::class);
Route::post('/api/AgregarLlavescsv','ApisController@AgregarLlavescsv')->middleware(adminCheckSess::class);
Route::post('/api/AgregarUsuario','ApisController@RegistrarUsuario')->middleware(adminCheckSess::class);
Route::put('/api/actualizarUsuario','ApisController@updateUser');
//Route::get('/api/buscarHorario/{codigo}/{hora}','ApisController@buscarHorario');
###############################################################################################################


//Route::get('/insert','LoginController@insertar');//esta es una ruta de prueba para insertar datos random
