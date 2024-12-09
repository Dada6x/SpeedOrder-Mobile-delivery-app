import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Screens/profile_page.dart';

PreferredSizeWidget ProjectAppBar_homePage() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: AppBar(
        //@ useful shit
      
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
              backgroundImage: AssetImage('assets/images/weekend.png'),
            ),
          ),
        ),
        title: Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Text('\' Location \''.tr),
          ),
        ),
      ),
    ),
  );
}
