import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mamamia_uniproject/main_page.dart';

class AllSetup extends StatelessWidget {
  const AllSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () {
                    //! of all pay attention niger
                    Get.offAll(const MainPage());
                  },
                  child: Text(
                    'Next'.tr,
                  )),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Expanded(
              flex: 6,
              child: Lottie.asset('assets/animations/true.json',
                  fit: BoxFit.cover),
            ),
          ),
          Text(
            'You are all set Up '.tr,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
