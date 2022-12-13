<?php

namespace App\Http\Controllers;

use App\Models\Log;
use App\Models\Mail;
use App\Models\Asigna;
use Illuminate\Http\Request;

class LogController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Log::with('user')->with('user2')->get();
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
        $loga=Log::where('id',$request->log_id)->with('mail')->firstOrFail();
        $loga->estado='REMITIDO';
        $loga->save();
      // return $log->mail->id;
        foreach ($request->datos as $list) {
        $log= new Log();
        $log->mail_id=$loga->mail->id;
        $log->log_id=$loga->id;
        $log->user_id=$request->user()->id;
        $log->user_id2=$list['listuser']['id'];
        $log->unit_id=$list['listuser']['unit_id'];
        $log->tipodoc=strtoupper($list['tipodoc']);
        $log->nfojas=$list['nfojas'];
        $log->observacion=$list['observacion'];
//        $log->remitente=$request->user()->name;
//        $log->destinatario=$list['name'];
        $log->accion=strtoupper($list['instruccion']);
        $log->estado='EN PROCESO';
        $log->fecha=date('Y-m-d');
        $log->hora=date('H:i:s');
//        $log->unit_id=$list['unit_id'];
            //return $log;
        $log->save();
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Log  $log
     * @return \Illuminate\Http\Response
     */
    public function show(Log $log)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Log  $log
     * @return \Illuminate\Http\Response
     */
    public function edit(Log $log)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Log  $log
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Log $log)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Log  $log
     * @return \Illuminate\Http\Response
     */
    public function destroy(Log $log)
    {
        //
    }
}
