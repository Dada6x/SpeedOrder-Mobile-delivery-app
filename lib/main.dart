import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:mamamia_uniproject/Controllers/userController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';
import 'package:mamamia_uniproject/Controllers/locationController_map.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/Controllers/credit_card_controller.dart';
import 'package:mamamia_uniproject/Controllers/f_a_q_controller.dart';
import 'package:mamamia_uniproject/Controllers/favoriteController.dart';
import 'package:mamamia_uniproject/Controllers/cart_controller.dart';
import 'package:mamamia_uniproject/Screens/IntroductionScreens/splash_screen.dart';
import 'package:mamamia_uniproject/Controllers/orders_controller.dart';
// import 'package:mamamia_uniproject/IntroductionScreens/IntroPages.dart';
// import 'package:mamamia_uniproject/IntroductionScreens/splash_screen.dart';
import 'package:mamamia_uniproject/language/local.dart';
import 'package:mamamia_uniproject/main_page.dart';
import 'package:mamamia_uniproject/middlewares/middleware.dart';
import 'package:mamamia_uniproject/theme/themes.dart';

//$-----------------------shared Preferences--------------
SharedPreferences? middleWarePref;
SharedPreferences? splashPref;
SharedPreferences? tokenPref;
SharedPreferences? userInfo;
//!-------------------------------------------------------
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
//!---------------------------MAIN------------------------
void main() async {
//?-----------------------Controllers---------------------
  Get.put(creditCardController());
  Get.put(FavoriteController());
  Get.put(HomePageProductController());
  Get.put(Model());
  Get.put(CartController());
  Get.put(FAQController());
  Get.put(OrdersController());
  Get.put(LocationController());
  Get.put(UserController());
//!-------------------------------------------------------
  middleWarePref = await SharedPreferences.getInstance();
  tokenPref = await SharedPreferences.getInstance();
  splashPref = await SharedPreferences.getInstance();
  userInfo = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ThemeProvider(
      initTheme: Themes().darkMode,
      builder: (p0, theme) => GetMaterialApp(
        //!----------------------- localization -------------------
        // ! languges
        translations: MyLocal(),
        locale: const Locale("en"),
        fallbackLocale: const Locale("en"),
        debugShowCheckedModeBanner: false,
        //@----------------------- themes -------------------------
        theme: theme,
        //*----------------------- middle wares -------------------
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const SplashScreen(), middlewares: [
            MiddlewareAuth(),
          ]),
          GetPage(name: '/login', page: () => const LoginPage()),
          GetPage(name: '/mainPage', page: () => const MainPage()),
        ],
        home: const SplashScreen(),
        //SettingLocation
      ),
    ),
  );
}
