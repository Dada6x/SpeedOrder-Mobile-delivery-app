<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\ConfirmController;
use App\Http\Controllers\FavoriteController;
use App\Http\Controllers\FavoritesController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\ProductController;
use App\Http\Middleware\Admin;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::group([

    'middleware' => 'api',
    'prefix' => 'auth'

], function ($router) {

    Route::post('login', [AuthController::class, 'login'])->name('login');
    Route::post('logout', [AuthController::class, 'logout'])->name('logout');
    Route::post('refresh', [AuthController::class, 'refresh'])->name('refresh');
    Route::post('me', [AuthController::class, 'me'])->name('me');


    Route::post('edit', [AuthController::class, 'edit'])->name('edit');
    Route::post('uploadImage', [AuthController::class, 'uploadImage'])->name('uploadImage');
    Route::post('change_password', [AuthController::class, 'changePassword'])->name('resetPassword');
    Route::post('change_language', [AuthController::class, 'changeLanguage']);
    // Route::post('showImage', [AuthController::class, 'showImage'])->name('showImage');


    Route::post('get_products', [ProductController::class, 'get_products'])->name('get_products');
    Route::post('get_companies', [ProductController::class, 'get_companies'])->name('get_companies');
    Route::post('get_products_of_company', [ProductController::class, 'getProductsOfCompany'])->name('getProductsOfCompany');
    Route::post('search_in_products', [ProductController::class, 'searchInProducts']);
    Route::post('search_in_companies', [ProductController::class, 'searchInCompanies']);
    Route::post('search', [ProductController::class, 'search'])->name('search');
    // Route::post('get_company_of_product', [ProductController::class, 'getCompanyOfProduct']);
    Route::post('get_details-for-product', [ProductController::class, 'getDetailsForProduct']);
    Route::post('get_products_by_category', [ProductController::class, 'getProductsByCategory']);

    Route::post('add_to_cart', [CartController::class, 'addToCart'])->name('addToCart');
    Route::post('get_total_price', [CartController::class, 'getTotalPrice'])->name('totalPrice');
    Route::post('get_count_in_cart', [CartController::class, 'getCountInCart']);
    Route::post('get_products_in_cart', [CartController::class, 'getProductsInCart'])->name('getProductInCart');
    Route::post('delete_from_cart', [CartController::class, 'deleteFromCart'])->name('deleteFromCart');
    Route::post('edit_cart', [CartController::class, 'editCart'])->name('editCart');
    Route::post('get_unread_notification', [NotificationController::class, 'getUnreadNotifications'])->name('getUnreadNotifications');
    Route::post('get_notifications', [NotificationController::class, 'getNotifications'])->name('getNotifications');
    Route::post('get_read_notifications', [NotificationController::class, 'getReadNotifications'])->name('getReadNotifications');
    Route::post('mark_as_read', [NotificationController::class, 'markAsRead']);
    Route::post('mark_all_as_read', [NotificationController::class, 'markAllAsRead']);

    Route::post('add_to_favorite', [FavoriteController::class, 'addToFavorite']);
    Route::post('add_to_cart_from_favorite', [FavoriteController::class, 'addToCartFromFavorite']);
    Route::post('delete_from_favorite', [FavoriteController::class, 'deleteFromFavorite']);
    Route::post('get_favorite_products', [FavoriteController::class, 'getFavoriteProducts']);
    Route::post('is_favorite', [FavoriteController::class, 'isFavorite']);

    Route::post('add_to_confirm', [ConfirmController::class, 'addToConfirm']);
    Route::post('cancel_order', [ConfirmController::class, 'cancelOrder']);
    Route::post('get_order_status', [ConfirmController::class, 'getOrderStatus']);

    Route::post('get_profile_image', [AuthController::class, 'getProfileImage']);
});
Route::post('add_product', [AdminController::class, 'addProduct'])->middleware(Admin::class, 'api');
Route::post('add_company', [AdminController::class, 'addCompany'])->middleware(Admin::class, 'api');
Route::post('add_admins', [AdminController::class, 'addAdmins'])->middleware(Admin::class, 'api');
Route::post('set_order_to_delivered', [AdminController::class, 'setOrderToDelivered'])->middleware(Admin::class);
Route::post('cancel_order', [AdminController::class, 'cancelOrder'])->middleware(Admin::class);
Route::post('get_orders', [AdminController::class, 'getOrders'])->middleware(Admin::class);
Route::post('get_orders_history', [AdminController::class, 'getOrdersHistory'])->middleware(Admin::class);
Route::post('register', [AuthController::class, 'register'])->name('register');

Route::post('import_product', [AdminController::class, 'import_from_json'])->name('import_product');
