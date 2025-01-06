import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';
import 'package:mamamia_uniproject/Controllers/locationController_map.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/Controllers/credit_card_controller.dart';
import 'package:mamamia_uniproject/Controllers/favoriteController.dart';
import 'package:mamamia_uniproject/Controllers/cart_controller.dart';
import 'package:mamamia_uniproject/IntroductionScreens/splash_screen.dart';
import 'package:mamamia_uniproject/language/local.dart';
import 'package:mamamia_uniproject/main_page.dart';
import 'package:mamamia_uniproject/middlewares/middleware.dart';
import 'package:mamamia_uniproject/theme/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

//!-----------------------------shared pref
SharedPreferences? middleWarePref;
SharedPreferences? splashPref;
SharedPreferences? tokenPref;
//!----------------------------
//!!!!--------------------
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
//!----------------------------
void main() async {
  Get.put(creditCardController());
  Get.put(FavoriteController());
  Get.put(HomePageProductController());
  Get.put(Model());
  Get.put(CartController());
  Get.put(LocationController());
  //middleware
  middleWarePref = await SharedPreferences.getInstance();
  tokenPref = await SharedPreferences.getInstance();
  splashPref = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      //! languges
      translations: MyLocal(),
      locale: const Locale("en"),
      fallbackLocale: const Locale("en"),
      //!
      debugShowCheckedModeBanner: false,
      //! i know its places wrong but i want the default theme to be the dark theme
      darkTheme: Themes().lightMode,
      theme: Themes().darkMode,
      // middlewares
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen(), middlewares: [
          MiddlewareAuth(),
        ]),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/mainPage', page: () => const MainPage()),
      ],
      home: const SplashScreen(),
    ),
  );
}
