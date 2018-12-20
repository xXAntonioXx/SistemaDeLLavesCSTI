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
use App\Http\Middleware\CheckSess;
use App\Http\Middleware\alreadyStartSession;

Route::get('/wc', function () {
    return view('welcome');
});

//rutas y metodos para el login de usuario
Route::get('/','LoginController@principal')->middleware(alreadyStartSession::class);
Route::post('/validate','LoginController@validar');//para validar el usuario en el login

//rutas para la pagina principal
Route::get('/main','PrincipalController@cargarRegistro')->middleware(CheckSess::class);
Route::get('/busqueda','PrincipalController@cargarBusqueda')->middleware(CheckSess::class);
Route::get('/inventario','PrincipalController@cargarInventario')->middleware(CheckSess::class);

Route::get('/salir','LoginController@salir');//opcion de salir

Route::get('/insert','LoginController@insertar');//esta es una ruta de prueba para insertar datos random

//API para consultar la base de datos
Route::post('/api/nuevoPrestamo','ApisController@nuevoPrestamo')->middleware(CheckSess::class);
//Route::post('/api/nuevoPrestamo','ApisController@nuevoPrestamo');
Route::post('/api/nuevoRegistro','ApisController@nuevoRegistro')->middleware(CheckSess::class);
Route::get('/api/registros','ApisController@registrosNum')->middleware(CheckSess::class);
Route::get('/api/lap','ApisController@lap')->middleware(CheckSess::class);
Route::get('/api/buscarHorario/{codigo}/{hora}','ApisController@buscarHorario')->middleware(CheckSess::class);
Route::get('/api/devolucionOprestamo/{codigo}','ApisController@Devolucion_O_Prestamo');
Route::get('api/obtenerObjetos/{idPrestamo}','ApisController@ObjetosPrestados');




