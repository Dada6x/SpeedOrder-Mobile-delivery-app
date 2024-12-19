import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:solar_icons/solar_icons.dart';

class LanguageToggleButtonIcon extends StatelessWidget {
  const LanguageToggleButtonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
          onPressed: () {
            Locale currentLocale = Get.locale ?? const Locale("en");
            Get.updateLocale(currentLocale.languageCode == "en"
                ? const Locale("ar")
                : const Locale("en"));
          },
          icon: Icon(SolarIconsBold.global,
              color: Theme.of(context).colorScheme.primary)),
    );
  }
}
