import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mamamia_uniproject/main_page.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

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
              child: const Text("signUp"),
            ),
          ),
        ],
      ),
    );
  }
}
