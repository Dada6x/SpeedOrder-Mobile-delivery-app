<?php

namespace Database\Factories;

use Carbon\Traits\ToStringFormat;
use Illuminate\Database\Eloquent\Factories\Factory;
use Nette\Utils\Arrays;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Product>
 */
class ProductFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'english_name'=>fake()->word(),
            'arabic_name'=>fake()->languageCode(),
            'count'=>fake()->randomNumber(6),
            'price'=>fake()->randomFloat(3, 0, 1000),
            'company_id'=>fake()->numberBetween(1, 10),
            'arabic_details'=>fake()->text(),
            'english_details'=>fake()->word(),
            'photo_path'=>fake()->filePath(),
            'category'=>fake()->randomElement(['clothes', 'devices', 'home', 'food'])
        ];
    }
}
