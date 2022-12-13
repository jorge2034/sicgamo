<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateLogsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('logs', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('mail_id')->nullable()->default(null);
            $table->foreign('mail_id')->references('id')->on('mails');

            $table->unsignedBigInteger('user_id')->nullable()->default(null);
            $table->foreign('user_id')->references('id')->on('users');

            $table->unsignedBigInteger('user_id2')->nullable()->default(null);
            $table->foreign('user_id2')->references('id')->on('users');
            $table->unsignedBigInteger('log_id')->nullable()->default(null);
            $table->foreign('log_id')->references('id')->on('logs');
            $table->unsignedBigInteger('unit_id')->nullable()->default(null);
            $table->foreign('unit_id')->references('id')->on('units');
            $table->string('estado')->default('EN PROCESO');
            $table->string('accion')->nullable()->default('');
            $table->string('archivado')->nullable()->default('');
            $table->date('fecha');
            $table->time('hora');
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
        Schema::dropIfExists('logs');
    }
}
