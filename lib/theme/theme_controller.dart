import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/main_page.dart';
import 'package:mamamia_uniproject/theme/themes.dart';

class ThemeController extends GetxController {
  bool isDarkMode = Get.isDarkMode;

  void toggleTheme() {
    if (isDarkMode) {
      Get.changeTheme(Themes().lightMode);
    } else {
      Get.changeTheme(Themes().darkMode);
    }
    isDarkMode = !isDarkMode;
    update(); // Trigger UI rebuild
  }
}

// should be in the components shit not here
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: ThemeController(),
      builder: (controller) {
        return TextButton.icon(
          onPressed: controller.toggleTheme,
          label: Text(
            controller.isDarkMode ? "Light Mode".tr : "Dark Mode".tr,
          ),
          icon: Icon(
            controller.isDarkMode ? Icons.sunny : Icons.nightlight_round,
            color: MainPage.orangeColor,
          ),
        );
      },
    );
  }
}
