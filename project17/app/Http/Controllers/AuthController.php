<?php

namespace App\Http\Controllers;
use App\Http\Controllers\Controller;
use App\Http\ProductTrait;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Nette\Utils\Random;

class AuthController extends Controller
{
    use ProductTrait;
    /**
     * Create a new AuthController instance.
     *
     * @return void
     */



    public function __construct()
    {
        //$this->middleware('auth:api', ['except' => ['login']]);
    }

    /**
     * Get a JWT via given credentials.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function login()
    {
        $credentials = request(['user_phone', 'password']);

        if (! $token = auth()->attempt($credentials)) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        return $this->respondWithToken($token);
    }

    /**
     * Get the authenticated User.
     *
     * @return \Illuminate\Http\JsonResponse
     */




    public function me()
    {
        return response()->json(auth()->user());
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
        auth()->logout();

        return response()->json(['message' => 'Successfully logged out']);
    }

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */








    public function refresh()
    {
        return $this->respondWithToken(auth()->refresh());
    }

    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */








    protected function respondWithToken($token)
    {
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL() * 60
        ]);
    }


    public function register(){
        $validator = Validator::make(request()->all(),
        [
            'last_name'=>'nullable|string|max:100',
            'name'=>'required|string|max:100',
            'user_phone'=>'required|digits:10|unique:users',
            'password'=>'required|max:1000|ascii',
            'photo'=>'image|max:1000|nullable'
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        $path = null;
        if(request()->photo!=null){
            $path = request()->file('photo')->store('users');
        }

        User::create([
            'name'=>request()->name,
            'user_phone'=>request()->user_phone,
            'password'=>Hash::make(request()->password),
            'last_name'=>request()->last_name,
            'photo_path'=>$path,
        ]);
        $this->sendSms(request()->user_phone , 'you are regestered as: '."\n".request()->name."\n".request()->password);
        return $this->login();
    }



    public function edit() {
        $validator = Validator::make(request()->all(),
        [
            'name'=>'max:100|required|string',
            'user_location'=>'max:1000|string|nullable',
            'last_name'=>'max:100|nullable|string',
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }

        User::find(auth()->user()->id)->update([
            'name'=>request()->name,
            'user_location'=>request()->user_location,
            'last_name'=>request()->last_name,
        ]);
        return response('updated successfully', 200);
    }




    public function uploadImage() {
        $validator = Validator::make(request()->all(),[
            'photo'=>'image|max:1000|required'
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        $user = auth()->user();
        if($user->photo_path!=null){
        $old_path =$user->photo_path;
        Storage::delete($old_path);
        }
        $path = request()->file('photo')->store('users');
        User::find($user->id)->update([
            'photo_path'=>$path,
        ]);
        return response($path, 200);
    }




    public function changePassword() {
        $validator = Validator::make(request()->all(),
        [
            'user_phone'=>'required|digits:10|exists:users',
            'password'=>'required|ascii|max:1000',
            'new_password'=>'max:1000|required|ascii'
        ]);
        if($validator->fails()){
            return response($validator->errors(), 400);
        }
        $credentials = request(['user_phone', 'password']);
        // if(auth()->user()->user_phone != request()->user_phone){
        //     return response()->json(['error' => 'Unauthorized'], 401);
        // }
        if (auth()->user()->user_phone != request()->user_phone||(! $token = auth()->attempt($credentials))) {
            return response()->json(['error' => 'Unauthorized'], 401);
            }

        User::find(auth()->user()->id)->update([
            'password'=>Hash::make(request()->new_password)
        ]);
        return response('reseted password successfully', 200);
    }

    public function changeLanguage()  {
        $temp = '';
        $user = auth()->user();
        if($user->language=='english'){
            $temp = 'arabic';
        }else{
            $temp = 'english';
        }
        User::find($user->id)->update([
            'language'=>$temp
        ]);
        return response('changed successfully', 200);
    }
    public function getProfileImage() {
        return Storage::download(auth()->user()->photo_path);
    }



    public function resetPassword() {
        $code = Random::generate(4, '0-9');
        // $this->sendSms(request()->user_phone, 'your activaion code is: '.$code);

    }






}
