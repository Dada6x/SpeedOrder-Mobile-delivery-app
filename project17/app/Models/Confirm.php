<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Confirm extends Model
{
    protected $fillable = ['user_id', 'user_location', 'price', 'status', 'card_password', 'card_number'];


    public function scopeCarts() {
        return $this->hasMany(Cart::class)->get();
    }
}
