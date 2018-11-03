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

Route::get('/wc', function () {
    return view('welcome');
});

//rutas y metodos para el login de usuario
Route::get('/','LoginController@principal');
Route::post('/validate','LoginController@validar');
Route::get('/prueba','LoginController@insertar');