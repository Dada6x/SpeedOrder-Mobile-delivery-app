<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProductResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */

    public function toArray(Request $request): array
    {
        $language = auth()->user()->language.'_name';
        return [
            'name'=>$this->$language,
            'photo_path'=>$this->photo_path,
            'price'=>$this->price,
            'id'=>$this->id
        ];
    }
}
