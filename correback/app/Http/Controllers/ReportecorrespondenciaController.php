<?php

namespace App\Http\Controllers;

use App\Models\Log;
use App\Models\Mail;
use Illuminate\Http\Request;

class ReportecorrespondenciaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        return Mail::with('logs')
            ->whereDate('fecha','>=',$request->fecha1)
            ->whereDate('fecha','<=',$request->fecha2)
            ->where('unit_id',$request->user()->unit_id)
            ->get();
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id,Request $request)
    {
        return $request->user();
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($fecha,Request $request)
    {
        return Log::where('unit_id',$request->user()->unit_id)
            ->whereDate('fecha',$fecha)
            ->get();
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }

    public function correspondenciaremitida(Request $request){
        if($request->tipodoc!='TODO'){
            $remitidos = Log::where('user_id',$request->user()->id)
            ->where('accion','<>','CREADO')
            //->orWhere('user_id2',$request->user()->id)
            ->whereDate('fecha','>=',$request->fecha1)
            ->whereDate('fecha','<=',$request->fecha2)
            ->where('tipodoc',$request->tipodoc)
            ->with(['mail','unit'])
            ->with(['user' => function ($query){
                $query->withTrashed();
            }])
            ->with(['user2' => function ($query){
                $query->withTrashed();
            }])
            ->get();
        }
        else{
            $remitidos = Log::where('user_id',$request->user()->id)
            ->where('accion','<>','CREADO')
            //->orWhere('user_id2',$request->user()->id)
            ->whereDate('fecha','>=',$request->fecha1)
            ->whereDate('fecha','<=',$request->fecha2)
            ->with(['mail','unit'])
            ->with(['user' => function ($query){
                $query->withTrashed();
            }])
            ->with(['user2' => function ($query){
                $query->withTrashed();
            }])
            ->get();
        }
        return $remitidos;
    }
    public function correspondenciarecibida(Request $request){
        $recibidos = Log::where('user_id2',$request->user()->id)
                ->whereDate('fecha','>=',$request->fecha1)
                ->whereDate('fecha','<=',$request->fecha2)
                ->whereIN('estado',['ACEPTADO','EN PROCESO'])
                ->where('accion','<>','CREADO')
                ->with(['mail','user'=> function ($query) {
                         $query->withTrashed()->with('unit');
                     },'unit'])
                ->with(['user2' => function ($query){
                        $query->withTrashed();
                    }])
                ->get();
        return $recibidos;
    }
    public function correspondenciapendiente(Request $request){
        $pendientes = Log::where('user_id2',$request->user()->id)
                ->whereIN('estado',['ACEPTADO','EN PROCESO'])
                ->with(['mail','user'=> function ($query) {
                         $query->withTrashed()->with('unit');
                     },'unit'])
                ->with(['user2' => function ($query){
                        $query->withTrashed();
                    }])
                 ->orderBy('estado','asc')
                 ->orderBy('updated_at','desc')
                //->orderByRaw("estado ASC, updated_at DESC")
                ->get();
        return $pendientes;
    }
    public function correspondenciaarchivada(Request $request){
        $archivados = Log::where('user_id2',$request->user()->id)
                ->whereDate('fecha','>=',$request->fecha1)
                ->whereDate('fecha','<=',$request->fecha2)
                ->whereIN('estado',['ARCHIVADO'])
                ->with(['mail','user'=> function ($query) {
                         $query->withTrashed()->with('unit');
                     },'unit'])
                ->with(['user2' => function ($query){
                        $query->withTrashed();
                    }])
                ->get();
        return $archivados;
    }
}





