import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mamamia_uniproject/main_page.dart';

class LanguageToggleButtonIcon extends StatelessWidget {
  const LanguageToggleButtonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Locale currentLocale = Get.locale ?? const Locale("en");
          Get.updateLocale(currentLocale.languageCode == "en"
              ? const Locale("ar")
              : const Locale("en"));
        },
        icon: Icon(Icons.translate_rounded,
            color: Theme.of(context).colorScheme.primary));
  }
}
