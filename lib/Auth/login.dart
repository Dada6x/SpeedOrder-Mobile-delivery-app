import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mamamia_uniproject/main_page.dart';
import 'package:mamamia_uniproject/Auth/signup.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: MaterialButton(
              color: Colors.green,
              onPressed: () {
                Get.off(() => const MainPage());
              },
              child: const Text(
                "login",
              ),
            ),
          ),
          Center(
            child: MaterialButton(
              color: Colors.orange,
              onPressed: () {
                Get.to(() => const Signup());
              },
              child: const Text("SignUp"),
            ),
          ),
        ],
      ),
    );
  }
}
