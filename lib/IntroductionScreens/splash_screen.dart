import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';
import 'package:mamamia_uniproject/IntroductionScreens/IntroPages.dart';
import 'package:mamamia_uniproject/main.dart';
import 'package:mamamia_uniproject/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 3)); 

    if (sharedPref?.getString("id") != null) {
      // If user is logged in
      Get.off(() => const MainPage());
    } else if (prefs?.getBool('isFirstOpen') == true) {
      // If first time is already completed, go to login
      Get.off(() => const LoginPage());
    } else {
      // Otherwise, show the introduction pages
      Get.off(() => const IntroPages());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/Food.png",
          width: double.infinity,
        ),
      ),
    );
  }
}
