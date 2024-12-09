import 'package:get/get_navigation/src/root/internacionalization.dart';

class MyLocal implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': english,
        "ar": arabic,
      };
}

const Map<String, String> english = {
  "Settings": "Settings",
  "' Location '": "' Location '",
  "Check Out": "Check Out",
  "Success": "Success",
  "added to the cart!": "added to the cart!",
  "Add to Cart": "Add to Cart",
  "Order History": "Order History",
  "Help Center": "Help Center",
  "Account Details": "Account Details",
  "Log out": "Log Out ",
  "Dark Mode": "Dark Mode",
  "Profile": "Profile",
  "Favorites": "Favorites",
  "Categories": "Categories",
  "Most popular": "Most popular",
  "Your Cart": "Your Cart",
  "Your cart is empty !": "Your cart is empty !",
  "Food": "Food",
  "Search": "Search",
  "Gifts": "Gifts",
  "Women": "Women",
  "Kids": "Kids",
  "User Name": "User Name",
  "Change language": "Change language",
  "Whats you're looking for?": "Whats you're looking for?",
  "Save": "Save",
  "Cancel": "Cancel",
  "Light Mode":"Light Mode"
};

const Map<String, String> arabic = {
  "Settings": "اعدادات",
  "Success": "تم بنجاح",
  "Check Out": "شراء",
  "added to the cart": "تمت اضافته للسلة",
  "Add to Cart": "اضافة للسلة",
  "Order History": "تاريخ الطلبات ",
  "' Location '": "الموقع",
  "Help Center": "مركز المساعدة",
  "Account Details": "اعدادات الحساب",
  "Log out": "تسجيل الخروج",
  "Dark Mode": "الوضع المظلم",
  "Profile": "الحساب الشخصي",
  "Favorites": "المفضلة",
  "Categories": "التصنيفات",
  "Most popular": " الاكثر رواجا",
  "Your Cart": "سلة مشترياتك ",
  "Your cart is empty !": "   اوميقاد سلتك فارغة !",
  "Search": "البحث",
  "Food": "طعام",
  "Gifts": "هدايا",
  "Women": "نساء",
  "Kids": "اطفال",
  "User Name": "اسم المستخدم",
  "Whats you're looking for?": "ما الذي تبحث عنه ؟",
  "Change language": "تغيير اللغة",
  "Save": "حفظ",
  "Cancel": "الغاء",
  "Light Mode":"الوضع الساطع"
};
