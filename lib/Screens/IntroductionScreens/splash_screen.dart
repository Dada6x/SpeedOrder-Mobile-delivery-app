import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';
import 'package:mamamia_uniproject/Screens/IntroductionScreens/IntroPages.dart';
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
    print(tokenPref?.getString("access_token"));
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 3));

    if (middleWarePref?.getString("id") != null) {
      Get.off(() => const MainPage());
    } else if (splashPref?.getBool('isFirstOpen') == true) {
      // If first time is already completed, go to login
      Get.off(() => const LoginPage());
    } else {
      Get.off(() => const IntroPages());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Expanded(child: Lottie.asset("assets/animations/amogus.json")),
      ),
    );
  }
}
