import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/location/Maps/locationController.dart';
import 'package:mamamia_uniproject/Auth/model.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/Controllers/credit_card_controller.dart';
import 'package:mamamia_uniproject/Controllers/favoriteController.dart';
import 'package:mamamia_uniproject/Controllers/cart_controller.dart';
import 'package:mamamia_uniproject/IntroductionScreens/IntroPages.dart';
import 'package:mamamia_uniproject/language/local.dart';
import 'package:mamamia_uniproject/theme/themes.dart';

void main() {
  Get.put(creditCardController());
  Get.put(FavoriteController());
  Get.put(HomePageProductController());
  Get.put(Model());
  Get.put(CartController());
  Get.put(LocationController());
  runApp(GetMaterialApp(
    //! languges
    translations: MyLocal(),
    locale: const Locale("en"),
    fallbackLocale: const Locale("en"),
    //!
    debugShowCheckedModeBanner: false,
    //! i know its places wrong but i want the default theme to be the dark theme
    darkTheme: Themes().lightMode,
    theme: Themes().darkMode,
    home: const IntroPages(),
    //intorpages
  ));
}
