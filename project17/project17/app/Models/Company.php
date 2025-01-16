<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Company extends Model
{
    use HasFactory;
    protected $fillable = ['name', 'phone', 'location'];
    public function scopeProducts() {
        $name = auth()->user()->language.'_name';
        return $this->hasMany(Product::class)->get(['id', $name, 'photo_path', 'price', 'category']);
    }
}
