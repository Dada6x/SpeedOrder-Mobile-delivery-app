<?php

namespace App\Http\Controllers;

use App\Models\Cart;
use App\Models\Company;
use App\Models\Confirm;
use App\Models\Product;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class AdminController extends Controller
{






    public function addProduct() {
        $validator = Validator::make(request()->all(),[
            'english_name'=>'required|string|max:100',
            'arabic_name'=>'required|max:100|string',
            'count'=>'integer|required|min:1',
            'price'=>'numeric|min:0|required',
            'english_details'=>'string|required|max:1000',
            'arabic_details'=>'string|required|max:1000',
            'company_id'=>'integer|required|min:1',
            'photo'=>'image|max:1000|required',
            'category'=>'alpha|required|max:10'
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        $path = request()->file('photo')->store('users');
        Product::create([
            'arabic_name'=>request()->arabic_name,
            'english_name'=>request()->english_name,
            'count'=>request()->count,
            'price'=>request()->price,
            'arabic_details'=>request()->arabic_details,
            'english_details'=>request()->english_details,
            'company_id'=>request()->company_id,
            'photo_path'=>$path,
            'category'=>request()->category
        ]);
        return response('added successfully', 200);
    }

    public function addCompany() {
        $validator = Validator::make(request()->all(),[
            'name'=>'required|string|max:100',
            'location'=>'string|required|max:1000',
            'phone'=>'digits:10|unique:companies|required'
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        Company::create([
            'name'=>request()->name,
            'location'=>request()->location,
            'phone'=>request()->phone
        ]);
        return response('added successfully', 200);
    }




    public function addAdmins() {
        $validator = Validator::make(request()->all, [
            'name'=>'max:100|required|string',
            'user_phone'=>'required|digits:10|unique:users',
            'password'=>'required|max:1000|string',
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        User::create([
            'name'=>request()->name,
            'user_phone'=>request()->user_phone,
            'password'=>Hash::make(request()->password),
            'status'=>'admin'
        ]);
        return response('added successfully', 200);
    }


    public function import_from_json()
    {
        set_time_limit(300);
        // قراءة محتوى ملف JSON
        $jsonData = file_get_contents(base_path('product.json'), true);

        // فك تشفير البيانات من JSON
        $products = json_decode($jsonData, true); // تحويله إلى مصفوفة

        // تحقق من أن البيانات تم تحميلها بنجاح
        if (!$products) {
            return response()->json(['error' => 'Invalid JSON format'], 400);
        }

        // استيراد كل منتج إلى قاعدة البيانات
        foreach ($products as $productData) {
            // معالجة الصورة إذا كان الرابط متوفرًا
            $photoPath = null;

            if (!empty($productData['photo_path']) && filter_var($productData['photo_path'], FILTER_VALIDATE_URL)) {
                try {
                    // إذا كان الرابط يحتوي على "OIP"، قم بتغيير الامتداد إلى jpg
                    if (strpos($productData['photo_path'], 'OIP') !== false) {
                        $extension = 'jpg'; // تغيير الامتداد إلى jpg إذا كان يحتوي على "OIP"
                    } else {
                        // إذا كان الرابط لا يحتوي على "OIP"، استخدم الامتداد الفعلي للصورة
                        $extension = pathinfo(parse_url($productData['photo_path'], PHP_URL_PATH), PATHINFO_EXTENSION);
                        // التأكد من أن الامتداد ليس فارغًا أو غير صالح
                        if (empty($extension)) {
                            $extension = 'jpg'; // تعيين الامتداد إلى jpg في حالة عدم وجود امتداد
                        }
                    }

                    // تنزيل الصورة
                    $response = Http::withOptions([
                        'verify' => false, // تعطيل التحقق من SSL
                    ])->get('https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg');

                    if ($response->successful()) {
                        // إنشاء اسم ملف فريد
                        $fileName = uniqid() . '.' . $extension;

                        // حفظ الصورة في مجلد التخزين
                        Storage::put("users/$fileName", $response->body());
                        // Storage::disk('public')->put("images/$fileName", $response->body());

                        // تعيين المسار للصورة المحفوظة
                        $photoPath = "users/$fileName";
                    }
                } catch (\Exception $e) {
                    // إذا حدث خطأ في تنزيل الصورة
                    $photoPath = null;
                }
            }

            // حفظ المنتج في قاعدة البيانات
            Product::create([
                'arabic_name' => $productData['arabic_name'],
                'english_name' => $productData['english_name'],
                'count' => $productData['count'],
                'price' => $productData['price'],
                'arabic_details' => $productData['arabic_details'],
                'english_details' => $productData['english_details'],
                'company_id' => $productData['company_id'],
                'photo_path' => $photoPath,
                'category' => $productData['category'],
            ]);
        }

        return response()->json(['message' => 'Products imported successfully'], 200);
    }



    public function addDrivers() {
        $validator = Validator::make(request()->all(), [
            'name'=>'max:100|required|string',
            'user_phone'=>'required|digits:10|unique:users',
            'password'=>'required|max:1000|string',
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        User::create([
            'name'=>request()->name,
            'user_phone'=>request()->user_phone,
            'password'=>Hash::make(request()->password),
            'status'=>'driver'
        ]);
        return response('added successfully', 200);
    }



    public function setOrderToDelivered() {
        $confirm = Confirm::find(request()->confirm_id);
        if ($confirm->status == 'pending'){
            $confirm->update([
                'status'=>'delivered'
            ]);
            return response('successfully', 200);
        }else{
            return response('order status is '.$confirm->status, 400);
        }
    }








    public function cancelOrder() {
        $confirm = Confirm::find(request()->confirm_id);
        if ($confirm->status == 'pending'){
            $confirm->update([
                'status'=>'canceled by admin'
            ]);
            $carts = $confirm->carts();
            foreach ($carts as $cart) {
                $product = Product::find($cart->product_id);
                $product->update([
                    'count'=>$cart->count + $product->count
                ]);
            }
        }
        else {
            return response("can't cancel the order", 400);
        }
        return response('canceled successfully', 200);
    }

    public function getOrders() {
        $orders = Confirm::where('status', 'pending')->get(['id', 'status', 'created_at', 'price', 'user_location']);
        for ($j=0; $j < $orders->count(); $j++) {
            $products = Confirm::find($orders[$j]->id)->carts();
            $temp = array();
        for ($i=0; $i < $products->count(); $i++) {
            $product = Cart::find($products[$i]->id)->products();
            $product['count'] = $products[$i]->count;
            array_push($temp, $product);
        }
        $orders[$j]['product_details'] = $temp;
    }
        return response($orders, 200);
}









public function getOrdersHistory() {
    $orders = Confirm::get(['id', 'status', 'created_at', 'price', 'user_location']);
        for ($j=0; $j < $orders->count(); $j++) {
            $products = Confirm::find($orders[$j]->id)->carts();
            $temp = array();
        for ($i=0; $i < $products->count(); $i++) {
            $product = Cart::find($products[$i]->id)->products();
            $product['count'] = $products[$i]->count;
            array_push($temp, $product);
        }
        $orders[$j]['product_details'] = $temp;
    }
        return response($orders, 200);
    }

}
