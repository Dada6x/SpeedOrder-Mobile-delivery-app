import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mamamia_uniproject/Auth/location/allsetup.dart';


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
          Center(
            child: Text(
              'Grant Current Location'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Center(child: Text('this let us show nearby stores'.tr)),
          Center(child: Text('and you can order form '.tr)),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(290, 45),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                Get.off(const Allsetup());
              },
              child: Text(
                maxLines: 1,
                'Use Current Location '.tr,
                style: const TextStyle(color: Colors.white, fontSize: 17),
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
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                Get.off(const Allsetup());
              },
              child: Text(
                maxLines: 1,
                'Enter manually'.tr,
                style: const TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
