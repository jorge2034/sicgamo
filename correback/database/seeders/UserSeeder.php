<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('users')->insert([
            ['tipo'=>'USUARIO','name'=>'ADMINISTRADOR','carnet'=>'1111','email'=>'admin@test.com','password'=>Hash::make('admin'),'fechalimite'=>'9999/01/01','unit_id'=>24],
            ['tipo'=>'USUARIO','name'=>'ADIMER PAUL CHAMBI AJATA','carnet'=>'1010','email'=>'a@gmail.com','password'=>Hash::make('123456'),'fechalimite'=>'9999/01/01','unit_id'=>23],
            ['tipo'=>'USUARIO','name'=>'ALEJANDRO LOPEZ','carnet'=>'2020','email'=>'b@gmail.com','password'=>Hash::make('123456'),'fechalimite'=>'9999/01/01','unit_id'=>10],
            ['tipo'=>'USUARIO','name'=>'GERMAN','carnet'=>'3030','email'=>'c@gmail.com','password'=>Hash::make('123456'),'fechalimite'=>'9999/01/01','unit_id'=>3],
        ]);
    }
}
