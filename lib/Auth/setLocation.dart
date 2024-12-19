import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mamamia_uniproject/Auth/allsetup.dart';
import 'package:mamamia_uniproject/components/location_dialog.dart';
import 'package:mamamia_uniproject/main_page.dart';

class SettingLocation extends StatelessWidget {
  const SettingLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Expanded(
              child: Lottie.asset('assets/animations/loaction.json',
                  fit: BoxFit.cover),
            ),
          ),
          const Center(
            child: Text(
              'Grant Current Location',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const Center(child: Text('this let us show nearby stores')),
          const Center(child: Text('and you can order form ')),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(290, 45),
                  backgroundColor: MainPage.orangeColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                Get.dialog(const LocationDialog());
              },
              child: const Text(
                maxLines: 1,
                'Enter Location ',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(290, 45),
                  backgroundColor: MainPage.orangeColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                Get.off(const Allsetup());
              },
              child: const Text(
                maxLines: 1,
                'Skip',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
