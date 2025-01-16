<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProfileResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'name' => $request->name,
            'last_name' => $request->last_name,
            'user_phone' => $request->user_phone,
            'user_location' => $request->user_location,
            'photo_path' => $request->photo_path,
            'language' => $request->language,

        ];
    }
}
