<?php

namespace App\Http\Controllers;

use App\Category;
use App\Http\ProductTrait;
use App\Models\Company;
use App\Models\Product;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class ProductController extends Controller
{
use ProductTrait;







    public function get_products() {
        $name = auth()->user()->language.'_name';
        $products = Product::get(['id', $name, 'price', 'photo_path', 'category']);
        $newProducts = $this->product_name($products, $name);
        return $newProducts;
    }




    public function get_companies(){
        return response(Company::get(['id', 'name', 'location', 'phone']), 200);
    }







    public function getProductsOfCompany()  {
        $name = auth()->user()->language.'_name';
        $products = Company::find(request()->company_id)->products();
        $newProducts = $this->product_name($products, $name);
        return $newProducts;
    }
    // public function getCompanyOfProduct() {
    //     return response(Product::find(request()->id)->company(), 200);
    // }


    public function searchInProducts() {
        $validator = Validator::make(request()->all(), [
            'search'=>'required|string|max:100'
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        $name = auth()->user()->language.'_name';
        $products = Product::whereany(['arabic_name', 'english_name'], 'like', '%'.request()->search.'%')->get(['id', $name, 'photo_path', 'price', 'category']);
        $newProducts = $this->product_name($products, $name);
        return $newProducts;
    }








    public function searchInCompanies() {
        $validator = Validator::make(request()->all(), [
            'search'=>'required|string|max:100'
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        $companies = Company::where('name', 'like', '%'.request()->search.'%')->get(['id', 'name', 'location', 'phone']);
        return $companies;
    }
    public function search() {
        $validator = Validator::make(request()->all(), [
            'search'=>'required|string|max:100'
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        $result =['companies'=>$this->searchInCompanies(), 'products'=> $this->searchInProducts()];
        return response($result, 200);
    }
    public function getDetailsForProduct()  {
        $max = Product::count();
        $validator = Validator::make(request()->all(), [
            'id'=>"integer|between:1,$max|required"
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        $name = auth()->user()->language.'_name';
        $details = auth()->user()->language.'_details';
        $products = Product::find(request()->id, ['id', $name, $details, 'count', 'price', 'photo_path', 'category']);
        $newProducts = $this->products_details($products);
        $company = Product::find(request()->id)->company();
        $newProducts['company_id'] = $company[0]->id;
        $newProducts['company_name'] = $company[0]->name;
        $newProducts['company_location'] = $company[0]->location;
        $newProducts['company_phone'] = $company[0]->phone;
        return response($newProducts, 200);
    }

    public function getProductsByCategory() {
        $validator = Validator::make(request()->all(), [
            'category'=>['required', 'max:10',
            Rule::enum(Category::class)
            ]
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        $name = auth()->user()->language.'_name';
        $products = Product::where('category', request()->category)->get(['id', $name, 'price', 'photo_path', 'category']);
        $newProducts = $this->product_name($products, $name);
        return $newProducts;

    }
}
