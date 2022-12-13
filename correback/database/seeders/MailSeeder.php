<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class MailSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('mails')->insert([
            "codigo"=>"SYS0001",
            "tipo"=>"INTERNO",
            "ref"=>"INVITACION",
            "remitente"=>"ARQ. GLADIZ",
            "cargo"=>"JEFA DE UNIDAD",
            "institucion"=>"CATASTRO",
            "fecha"=>"2021-01-01",
            "fechacarta"=>"2021-01-01",
            "folio"=>"2",
            "codinterno"=>"1",
            "codexterno"=>"CAT0001",
            'user_id'=>"2",
            'unit_id'=>"1",
        ]);
    }
}
