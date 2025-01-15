<?php

namespace App\Models;

use App\Http\ProductTrait;
use Illuminate\Database\Eloquent\Model;

class Cart extends Model
{
    use ProductTrait;
    protected $fillable = [
        'user_id',
        'product_id',
        'count',
        'company_id',
        'user_location',
        'price',
        'confirm_id',
        'is_visible'
    ];



    public function scopeProducts() {
        $name = auth()->user()->language.'_name';
        $products = $this->belongsTo(Product::class, 'product_id')->get(['id', $name, 'photo_path', 'price', 'category']);
        return $this->product($products, $name);
    }
}
