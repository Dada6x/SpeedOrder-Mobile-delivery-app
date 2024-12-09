import 'package:flutter/material.dart';
import 'package:get/get.dart';

// this is the app bar for the most of the screens except the home screen coz it has Location and notifications
PreferredSizeWidget NormalAppBar(String text) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    surfaceTintColor: Colors.transparent,
    forceMaterialTransparency: true,
    elevation: 0,
    title: Directionality(
      textDirection: Get.locale?.languageCode == 'ar'
          ? TextDirection.rtl // RTL for Arabic
          : TextDirection.ltr, // LTR for English
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    ),
  );
}
