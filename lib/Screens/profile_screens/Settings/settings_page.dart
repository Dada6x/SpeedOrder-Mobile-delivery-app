import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';
import 'package:mamamia_uniproject/Controllers/profile_controller.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/Settings/comp/settings_comps.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/Settings/comp/settings_section.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/Settings/notifications_page.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  bool isEn = false;
// location
// themes
// idk :D
  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return Scaffold(
      appBar: NormalAppBar("Settings".tr),
      body: Container(
        // color: theme.secondaryHeaderColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsSection(
              title: "General".tr,
            ),
            SettingsComps(
              title: "Language".tr,
              icon: const Icon(Icons.language_sharp),
              destination: () {
                Locale currentLocale = Get.locale ?? const Locale("en");
                Get.updateLocale(currentLocale.languageCode == "en"
                    ? const Locale("ar")
                    : const Locale("en"));
              },
              trailing: Text(
                "English".tr,
                style: SettingsTextStyle(context),
              ),
            ),
            SettingsComps(
              title: "Location".tr,
              icon: const Icon(Icons.map),
              destination: () {
                Get.to(const LoginPage());
              },
            ),
            SettingsSection(title: "Account"),
            SettingsComps(
              title: "User Name".tr,
              icon: Icon(Icons.person),
              destination: () {},
              trailing: Text(
                'Name'.tr,
                style: SettingsTextStyle(context),
              ),
            ),
            SettingsComps(
              title: "Phone Number".tr,
              icon: Icon(Icons.phone),
              destination: () {},
              trailing: Text(
                'Number'.tr,
                style: SettingsTextStyle(context),
              ),
            ),
            SettingsComps(
              title: "Password".tr,
              icon: Icon(Icons.lock),
              destination: () {},
              trailing: Text(
                '+963 09** *** ***',
                style: SettingsTextStyle(context),
              ),
            ),
            SettingsSection(title: "Notifications".tr),
            SettingsComps(
                title: "Enable Notifications".tr,
                icon: Icon(Icons.notifications),
                destination: () {
                  Get.to(NotificationsPage());
                }),
          ],
        ),
      ),
    );
  }

  TextStyle SettingsTextStyle(BuildContext context) =>
      TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15);
}
