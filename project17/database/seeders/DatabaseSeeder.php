<?php

namespace Database\Seeders;

use App\Models\Company;
use App\Models\Product;
use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();
        Company::factory(10)->create();
        Product::factory(100)->create();
        User::factory()->create([
            'name' => 'mohammed',
            'user_phone'=>'0912345678',
            'password'=>Hash::make('poiuytrewq'),
            'email' => 'mohammed@gmail.com',
            'status'=>'admin'
        ]);
        Product::factory()->create([
            // 'arabic_name'=>
            // 'english_name'=>
            // 'arabic_details'=>
            // 'english_details'=>
            // 'price'=>
            // 'photo_path'=>
            // 'category'=>
            // 'count'=>
            // 'company_id'=>

        ]);
        Product::factory()->create([

        ]);
    }
}
