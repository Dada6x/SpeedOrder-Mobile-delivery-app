import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Screens/profile_page.dart';
import 'package:mamamia_uniproject/components/location_dialog.dart';

PreferredSizeWidget ProjectAppBar_homePage() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: AppBar(
        scrolledUnderElevation: 0.0,
        surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: GestureDetector(
            onTap: () => Get.to(const ProfilePage()),
            child: const CircleAvatar(
              radius: 10,
              //! THE USER IMAGE
              backgroundImage: AssetImage('assets/images/weekend.png'),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 8),
              onPressed: () {
                Get.dialog(barrierDismissible: false, const LocationDialog());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('\' Location \''.tr),
              )),
        ),
      ),
    ),
  );
}
