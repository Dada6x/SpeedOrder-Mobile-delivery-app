<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;
    public function scopeCompany() {
        return $this->belongsTo(Company::class, 'company_id')->get(['id', 'name', 'location', 'phone']);
    }
    protected $fillable = ['count', 'english_name', 'arabic_name', 'english_details', 'arabic_details', 'company_id', 'price', 'category', 'photo_path'];
}
