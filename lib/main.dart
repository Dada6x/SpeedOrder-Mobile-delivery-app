import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/cart_controller.dart';
import 'package:mamamia_uniproject/language/local.dart';

import 'package:mamamia_uniproject/main_page.dart';
import 'package:mamamia_uniproject/theme/themes.dart';

void main() {
  Get.put(CartController());
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
    home: const MainPage(),
  ));
}
