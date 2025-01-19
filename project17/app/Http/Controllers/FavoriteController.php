<?php

namespace App\Http\Controllers;

use App\Models\Cart;
use App\Models\Favorite;
use App\Models\Product;
use App\Models\User;
use App\Notifications\Status;
use Illuminate\Support\Facades\Notification;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;







class FavoriteController extends Controller
{








    public function addToFavorite() {
        $validator = Validator::make(request()->all(),[
            'product_id'=>['integer', 'min:1',
            Rule::unique('favorites', 'product_id')->where('user_id', auth()->user()->id)],
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        Favorite::create([
            'user_id'=>auth()->user()->id,
            'product_id'=>request()->product_id,
        ]);
        return response('added successfully', 200);
    }






    public function addToCartFromFavorite() {
        $favorite = Favorite::find(request()->favorite_id);
        $max = Product::find($favorite->product_id)->count;
        $validator = Validator::make(request()->all(),[
            'count'=>"min:1|integer|max:$max",
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        Cart::create([
            'user_id'=>auth()->user()->id,
            'product_id'=>$favorite->product_id,
            'count'=>request()->count,
        ]);
        Product::find($favorite->product_id)->update([
            'count'=>($max - request()->count)
        ]);
        $user = User::find(auth()->user()->id);
        Notification::send($user, new Status('added successfully'));
        return response('added successfully', 200);
    }









    public function deleteFromFavorite() {
        $validator = Validator::make(request()->all(),[
            'favorite_id'=>'integer|min:1|required'
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        Favorite::find(request()->favorite_id)->delete();
        return response('deleted successfully', 200);
    }
    public function isFavorite() {
        $validator = Validator::make(request()->all(),[
            'id'=>'integer|min:1|required'
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        if(!Favorite::where('user_id', auth()->user()->id)->where('product_id', request()->id)->get()->isEmpty()){
            return "true";
        }
        else{
            return "false";
        }
    }






    public function getFavoriteProducts() {
        $favorites = User::find(auth()->user()->id)->favorites();
        $products = [];
        for ($i=0; $i < $favorites->count(); $i++) {
            $products[$i]['id'] = $favorites[$i]->id;
            $products[$i]['product_details'] = Favorite::find($favorites[$i]->id)->products();
        }
        return response($products, 200);
    }


    public function deleteAllFromFavorite() {
        Favorite::where('user_id', auth()->user()->id)->delete();
        return response('deleted successfully', 200);
    }
}
