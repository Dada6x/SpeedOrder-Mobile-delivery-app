<?php
namespace App\Http;

use App\Models\Favorite;
use App\Models\Product;
use App\Models\User;

trait ProductTrait
{








    public function product_name($products, $name) {
        for ($i=0; $i < $products->count(); $i++) {
            $newProduct[$i]['name'] = $products[$i][$name];
            $newProduct[$i]['id'] = $products[$i]['id'];
            $newProduct[$i]['price'] = $products[$i]['price'];
            $newProduct[$i]['photo_path'] = $products[$i]['photo_path'];
            $newProduct[$i]['category'] = $products[$i]['category'];
            if(Favorite::where('user_id', auth()->user()->id)->where('product_id', $products[$i]['id'])->get()->isEmpty()){
                $temp = false;
            }
            else{
                $temp = true;
            }
            $newProduct[$i]['is_favorite'] = $temp;
        }

        return $newProduct;
    }







        public function products_details($products) {
            $user = auth()->user();
            $name =$user->language.'_name';
            $details = $user->language.'_details';
                $newProduct['name'] = $products->$name;
                $newProduct['id'] = $products->id;
                $newProduct['price'] = $products->price;
                $newProduct['photo_path'] = $products->photo_path;
                $newProduct['details'] = $products->$details;
                $newProduct['count'] = $products->count;
                $newProduct['category'] = $products->category;
                if(Favorite::where('product_id', $products->id)->get()->isEmpty()){
                    $temp = false;
                }
                else{
                    $temp = true;
                }
                $newProduct['is_favorite'] = $temp;
            return $newProduct;
        }


        public function product($product, $name) {
            $newProduct['id'] = $product[0]['id'];
            $newProduct['name'] = $product[0][$name];
            $newProduct['price'] = $product[0]['price'];
            $newProduct['photo_path'] = $product[0]['photo_path'];
            $newProduct['category'] = $product[0]['category'];
            if(Favorite::where('product_id', $product[0]['id'])->get()->isEmpty()){
                $temp = false;
            }
            else{
                $temp = true;
            }
            $newProduct['is_favorite'] = $temp;
            return $newProduct;
        }








        public function getTotalPrice() {
            $totalPrice = 0;
        foreach (User::find(auth()->user()->id)->productsInCart() as $cart) {
            $totalPrice =Product::find($cart->product_id)->price * $cart->count + $totalPrice;
        }
        return $totalPrice;
        }
}


