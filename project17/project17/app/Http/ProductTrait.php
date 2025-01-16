<?php
namespace App\Http;

use App\Models\Favorite;
use App\Models\Product;
use App\Models\User;
use Illuminate\Support\Facades\Http;

trait ProductTrait
{








    public function product_name($products, $name) {
        $newProduct = [];
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




        public function sendSms($phone, $message)
    {

        $phone1 = '+963' . ltrim($phone, '0'); //مشان سوريا


        $endpoint = "http://192.168.52.225:8082";
        $token = "f48db991-9bf1-4aa5-bd78-895e17d02723";

        try {
            // إرسال الطلب
            $data = [
                'to' => $phone1,
                'message' => $message,
            ];


            $response = Http::withHeaders([
                'Authorization' => $token,
            ])->post($endpoint, $data);

            // تحقق من نجاح الاستجابة
            if ($response->successful()) {
                return 'Message sent successfully';
            } else {


                return 'Failed to send message';
            }
        } catch (\Exception $e) {

            return 'Failed to send message';
        }




    }





}


