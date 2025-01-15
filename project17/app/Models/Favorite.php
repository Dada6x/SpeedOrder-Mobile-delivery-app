<?php

namespace App\Models;

use App\Http\ProductTrait;
use Illuminate\Database\Eloquent\Model;

class Favorite extends Model
{
    use ProductTrait;
    protected $fillable = ['user_id', 'product_id'];
    public function scopeProducts() {
        $name = auth()->user()->language.'_name';
        $products =  $this->belongsTo(Product::class, 'product_id')->get(['id', 'price', 'photo_path', $name]);
        return $this->product($products, $name);
    }
}
