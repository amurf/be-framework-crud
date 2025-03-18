<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Todo extends Model
{
    protected $fillable = [
        'title',
        'completed',
        'created_at'
    ];

    protected $casts = [
        'completed' => 'boolean',
        'created_at' => 'datetime'
    ];
}
