<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PermisoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('permisos')->insert([
            ["nombre"=>'Control de usuarios'],
            ["nombre"=>'Registrar correspondencia'],
            ["nombre"=>'Mis designaciones'],
            ["nombre"=>'Realizar seguimiento'],
        ]);
    }
}
