import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';
import 'package:mamamia_uniproject/Screens/settings/notifications_page.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/components/settings/settings_comps.dart';
import 'package:mamamia_uniproject/components/settings/settings_section.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final Locale currentLocale = Get.locale ?? const Locale("en");

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
        color: Color(0xffF0F0F0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingsSection(
              title: "General",
            ),
            SettingsComps(
              title: "Langugae",
              icon: const Icon(Icons.language_sharp),
              destination: () {},
              trailing: Text(
                currentLocale.languageCode == "en" ? "English" : "Arabic",
                style: SettingsTextStyle(theme),
              ),
            ),
            SettingsComps(
              title: "Location",
              icon: const Icon(Icons.map),
              destination: () {
                Get.to(const LoginPage());
              },
            ),
            SettingsSection(title: "Account"),
            SettingsComps(
              title: "User Name",
              icon: Icon(Icons.person),
              destination: () {},
              trailing: Text(
                'Name',
                style: SettingsTextStyle(theme),
              ),
            ),
            SettingsComps(
              title: "Phone Number",
              icon: Icon(Icons.phone),
              destination: () {},
              trailing: Text(
                'number',
                style: SettingsTextStyle(theme),
              ),
            ),
            SettingsComps(
              title: "Password",
              icon: Icon(Icons.lock),
              destination: () {},
              trailing: Text(
                '+963 09** *** ***',
                style: SettingsTextStyle(theme),
              ),
            ),
            SettingsSection(title: "Notifications"),
            SettingsComps(
                title: "Enable Notifications",
                icon: Icon(Icons.notifications),
                destination: () {
                  Get.to(NotificationsPage());
                }),
          ],
        ),
      ),
    );
  }

  TextStyle SettingsTextStyle(ThemeData theme) =>
      TextStyle(color: theme.primaryColor, fontSize: 15);
}
