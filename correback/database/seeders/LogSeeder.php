<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class LogSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('logs')->insert([
            'mail_id'=>"1",
            'user_id'=>"1",
            'user_id2'=>"2",
            'remitente'=>"ADMINISTRADOR",
            'destinatario'=>"ADIMER PAUL CHAMBI AJATA",
            'estado'=>"EN PROCESO",
            'accion'=>"",
            'fecha'=>"2021-01-01",
            'hora'=>"12:00",
            'unit_id'=>"1",

        ]);
    }
}
