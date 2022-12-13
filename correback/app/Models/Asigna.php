<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Asigna extends Model
{
    use HasFactory;
    protected $fillable=[
        'mail_id',
        'user_id',
        'unit_id',
        'fecha_reg',
        'estado',
    ];
    public function user(){
        return $this->belongsTo(User::class);
    }

    public function mail(){
        return $this->belongsTo(Mail::class)->with('logs');
    }

}
