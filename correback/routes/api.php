<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

//Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//    return $request->user();
//});
Route::post('/buscar',[\App\Http\Controllers\MailController::class,'buscar']);
Route::post('/login',[\App\Http\Controllers\UserController::class,'login']);
Route::post('/register',[\App\Http\Controllers\UserController::class,'register']);
Route::resource('/unit',\App\Http\Controllers\UnitController::class);
Route::get('/todos',[\App\Http\Controllers\MailController::class,'todos']);
//Route::resource('/log',\App\Http\Controllers\LogController::class);
Route::group(['middleware'=>['cors','auth:sanctum']],function (){
    Route::post('/logout',[\App\Http\Controllers\UserController::class,'logout']);
    Route::post('/me',[\App\Http\Controllers\UserController::class,'me']);
    Route::put('/pass/{user}',[\App\Http\Controllers\UserController::class,'pass']);
    Route::put('/updatepermisos/{user}',[\App\Http\Controllers\UserController::class,'updatepermisos']);

    Route::resource('/user',\App\Http\Controllers\UserController::class);
    Route::resource('/mail',\App\Http\Controllers\MailController::class);
    Route::resource('/log',\App\Http\Controllers\LogController::class);
    Route::resource('/asignacion',\App\Http\Controllers\AsignacionController::class);
    Route::resource('/reportecorrespondencia',\App\Http\Controllers\ReportecorrespondenciaController::class);
    Route::post('/reportecorrespondenciaremitida',[\App\Http\Controllers\ReportecorrespondenciaController::class,'correspondenciaremitida']);
    Route::post('/reportecorrespondenciarecibida',[\App\Http\Controllers\ReportecorrespondenciaController::class,'correspondenciarecibida']);
    Route::post('/reportecorrespondenciapendiente',[\App\Http\Controllers\ReportecorrespondenciaController::class,'correspondenciapendiente']);
    Route::post('/reportecorrespondenciaarchivada',[\App\Http\Controllers\ReportecorrespondenciaController::class,'correspondenciaarchivada']);
    Route::post('/updatemail',[\App\Http\Controllers\MailController::class,'updatemail']);
    Route::get('/micorre',[\App\Http\Controllers\MailController::class,'micorre']);
    Route::post('/micorre2',[\App\Http\Controllers\MailController::class,'micorre2']);
//    Route::post('/buscar',[\App\Http\Controllers\MailController::class,'buscar']);
    Route::post('/dividir',[\App\Http\Controllers\MailController::class,'dividir']);
    Route::post('/anulado',[\App\Http\Controllers\MailController::class,'anulado']);
    Route::post('/desarchivar',[\App\Http\Controllers\MailController::class,'desarchivar']);
    Route::post('/archivar',[\App\Http\Controllers\MailController::class,'archivar']);
    Route::post('/aceptar',[\App\Http\Controllers\MailController::class,'aceptar']);
    Route::post('/misremetentes',[\App\Http\Controllers\UserController::class,'misremetentes']);
    Route::post('/usuarios',[\App\Http\Controllers\UserController::class,'usuarios']);
    Route::post('/consulta',[\App\Http\Controllers\MailController::class,'consulta']);
    // Route::get('/todos',[\App\Http\Controllers\MailController::class,'todos']);
    Route::resource('/permiso',\App\Http\Controllers\PermisoController::class);

    Route::post('/upload',[\App\Http\Controllers\MailController::class,'upload']);
    Route::post('/impruta/{id}',[\App\Http\Controllers\MailController::class,'impruta']);
    Route::post('/impblanco/{id}',[\App\Http\Controllers\MailController::class,'impblanco']);
    Route::get('/destinatarios',[\App\Http\Controllers\MailController::class,'destinatarios']);
    Route::post('/buscarhijos',[\App\Http\Controllers\MailController::class,'buscarhijosparacancelarderivacion']);
});
Route::get('/mail/{mail}/{user}',[\App\Http\Controllers\MailController::class,'show2']);

Route::post('/con',[\App\Http\Controllers\MailController::class,'con']);
