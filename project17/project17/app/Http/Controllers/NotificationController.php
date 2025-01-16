<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Notifications\Notifiable;

class NotificationController extends Controller
{
    use Notifiable;

    public function getUnreadNotifications() {
        return response(auth()->user()->unreadNotifications, 200);
    }







    public function getNotifications() {
        return response(auth()->user()->notifications, 200);
    }







    public function getReadNotifications()  {
        return response(auth()->user()->readNotifications, 200);
    }







    public function markAsRead() {
        $notifications =  auth()->user()->unreadNotifications;
        foreach ($notifications as $notification) {
            if($notification->id == request()->id){
            $notification->markAsRead();
            return response('marked as read successfully', 200);
            }
        }
        return response('notification not found', 400);
    }
    public function markAllAsRead() {

        $notifications = auth()->user()->unreadNotifications;
        foreach ($notifications as $notification) {
            $notification->markAsRead();
        }
        return response('marked all as read successfully', 200);
    }
}
