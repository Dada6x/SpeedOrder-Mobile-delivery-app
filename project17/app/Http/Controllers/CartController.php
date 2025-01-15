<?php

namespace App\Http\Controllers;

use App\Models\Cart;
use App\Models\Product;
use App\Models\User;
use App\Notifications\detailsPaid;
use App\Notifications\Status;
use Brick\Math\Internal\Calculator;
use Brick\Math\Internal\Calculator\BcMathCalculator;
use Illuminate\Http\Request;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Notification;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;



class CartController extends Controller
{
use Notifiable;







    public function addToCart() {
        $max = Product::find(request()->product_id)->count;
        $validator = Validator::make(
            request()->all(),
            [
                'count'=>"integer|min:1|max:$max"
            ]
        );
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        Cart::create([
            'user_id'=>auth()->user()->id,
            'product_id'=>request()->product_id,
            'count'=>request()->count,
        ]);
        Product::find(request()->product_id)->update([
            'count'=>($max - request()->count)
        ]);
        $user = User::find(auth()->user()->id);
        Notification::send($user, new Status('added successfully'));
        return response('added successfully', 200);
    }







    public function getTotalPrice() {
        $totalPrice = 0;
        foreach (User::find(auth()->user()->id)->productsInCart() as $cart) {
            $totalPrice =Product::find($cart->product_id)->price * $cart->count + $totalPrice;
        }
        return response($totalPrice, 200);
    }



    public function getCountInCart() {
        $count = 0;
        foreach (User::find(auth()->user()->id)->productsInCart() as $cart) {
            $count = $cart->count + $count;
        }
        return response($count, 200);
    }



    public function getProductsInCart() {
        $products = User::find(auth()->user()->id)->productsInCart();
        for ($i=0; $i < $products->count(); $i++) {
            $product = Cart::where('is_visible', true)->find($products[$i]->id)->products();
            $productsInCart[$i]['id'] = $products[$i]->id;
            $productsInCart[$i]['product_details'] = $product;
            // return $productsInCart;
            // $productsInCart[$i]['id'] =$product[0]->id;
            // $productsInCart[$i]['name'] = $product[0]->name;
            // $productsInCart[$i]['photo_path'] = $product[0]->photo_path;
            // $productsInCart[$i]['price'] = $product[0]->price;
        }
        return response($productsInCart, 200);
    }







    public function deleteFromCart() {
        $cart = Cart::where('is_visible', true)->find(request()->id);
        $count = Product::find($cart->product_id)->count;
        Product::find($cart->product_id)->update([
            'count'=>($count+ $cart->count)
        ]);
        Cart::where('is_visible', true)->find(request()->id)->delete();
        $user = User::find(auth()->user()->id);
        Notification::send($user, new Status('deleted successfully'));
        return response('deleted successfully', 200);
    }









    public function editCart() {
        $cart = Cart::where('is_visible', true)->find(request()->id);
        $count = Product::find($cart->product_id)->count;
        $max = ($count+ $cart->count);
        $validator = Validator::make(request()->all(),
        [
            'count'=>"integer|required|max:$max",
        ]
        );
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        $temp = ($cart->count - request()->count);
        Product::find($cart->product_id)->update([
        'count'=>($count + $temp)
        ]);

        Cart::where('is_visible', true)->find(request()->id)->update([
            'count'=>request()->count
        ]);
        $user = User::find(auth()->user()->id);
        Notification::send($user, new Status('edited successfully'));
        return response('edited successfully', 200);
    }






}
