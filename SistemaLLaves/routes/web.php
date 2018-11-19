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

Route::get('/wc', function () {
    return view('welcome');
});

//rutas y metodos para el login de usuario
Route::get('/','LoginController@principal');
Route::post('/validate','LoginController@validar');
Route::get('/prueba','LoginController@insertar');

//rutas para la pagina principal
Route::get('/main','PrincipalController@cargarRegistro')->middleware(CheckSess::class);

Route::get('/salir','LoginController@salir');

Route::get('/insert','LoginController@insertar');//esta es una ruta de prueba para insertar datos random

//API para consultar la base de datos
Route::get('/api/registros','ApisController@registrosNum');
Route::get('/api/lap','ApisController@lap');