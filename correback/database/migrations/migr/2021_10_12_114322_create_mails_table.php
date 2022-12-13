<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMailsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mails', function (Blueprint $table) {
            $table->id();
            $table->string("codigo");
            $table->string("tipo")->default('INTERNO');
            //$table->string("tipo2")->default('ARCHIVO');
            $table->string("ref");
            $table->string("remitente");
            $table->string("destinatario");
            $table->string("cargo");
            $table->string("institucion");
            $table->date("fecha");
            $table->time("hora");
            $table->date("fechacarta");
            $table->string("estado")->default('EN PROCESO');
            $table->string("folio");
            $table->string("cite");
            $table->string("citecontrol");
            $table->string("archivo")->nullable()->default('');
            $table->string("codinterno")->nullable();
            $table->string("codexterno")->nullable();
            $table->unsignedBigInteger('user_id')->nullable();
            $table->foreign('user_id')->references('id')->on('users');
            $table->unsignedBigInteger('unit_id')->nullable();;
            $table->foreign('unit_id')->references('id')->on('units');
            //$table->unsignedBigInteger('mail_id')->nullable()->default(null);
            //$table->foreign('mail_id')->references('id')->on('mails');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('mails');
    }
}
