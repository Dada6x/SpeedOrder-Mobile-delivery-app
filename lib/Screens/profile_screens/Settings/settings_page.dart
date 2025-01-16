import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/Controllers/locationController_map.dart';
import 'package:mamamia_uniproject/Location/dialogs/location_dialog.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/Settings/dialogs/edit_name_dialog.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/Settings/dialogs/edit_password_dialog.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/Settings/dialogs/edit_phonenNumber_dialog.dart';
import 'package:mamamia_uniproject/components/settings_comps.dart';
import 'package:mamamia_uniproject/components/settings_section.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/Settings/notifications_page_thesettings.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/main.dart';
import 'package:mamamia_uniproject/theme/theme_controller.dart';
import 'package:http/http.dart' as http;

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // We no longer need to store 'location' locally here
    return Scaffold(
        appBar: NormalAppBar("Settings".tr),
        body: GetBuilder(
          init: ThemeController(),
          builder: (controller) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsSection(
                  title: "General".tr,
                ),
                SettingsComps(
                  title: "Language".tr,
                  icon: const Icon(Icons.language_sharp),
                  destination: () async {
                    String? token = await Get.find<Model>().getToken();
                    final response = await http.post(
                        Uri.parse(
                            "http://192.168.1.110:8000/api/auth/change_language"),
                        body: {"token": token});
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
                  title: "Change Theme".tr,
                  destination: () {
                    controller.toggleTheme();
                  },
                  icon: Icon(
                    controller.isDarkMode
                        ? Icons.sunny
                        : Icons.nightlight_round,
                  ),
                  trailing: Text(
                    controller.isDarkMode ? "Light Mode".tr : "Dark Mode".tr,
                    style: SettingsTextStyle(context),
                  ),
                ),
                const SettingsSection(title: "Account"),
                SettingsComps(
                  title: "User Name".tr,
                  icon: const Icon(Icons.person),
                  destination: () {
                    Get.dialog(const EditNameDialog());
                  },
                  trailing: Text(
                    userInfo!.getString("name").toString(),
                    style: SettingsTextStyle(context),
                  ),
                ),
                SettingsComps(
                  title: "Phone Number".tr,
                  icon: const Icon(Icons.phone),
                  destination: () {
                    Get.dialog(const EditNumberDialog());
                  },
                  trailing: Text(
                    userInfo!.getString("number").toString(),
                    style: SettingsTextStyle(context),
                  ),
                ),
                SettingsComps(
                  title: "Password".tr,
                  icon: const Icon(Icons.lock),
                  destination: () {
                    Get.dialog(const EditPasswordDialog());
                  },
                  trailing: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      '****** *** ***',
                      style: SettingsTextStyle(context),
                    ),
                  ),
                ),
                //! location
                //! new setting
                Card(
                  margin: const EdgeInsets.all(0.0),
                  child: ListTile(
                    tileColor: Theme.of(context).colorScheme.secondary,
                    onTap: () => Get.dialog(const LocationDialog()),
                    title: const Expanded(
                      child: Text(
                        "Location",
                        style: TextStyle(),
                      ),
                    ),
                    isThreeLine: false,
                    leading: const Icon(Icons.map),
                    iconColor: Theme.of(context).colorScheme.primary,
                    trailing: SizedBox(
                      width: 150,
                      child: Obx(() {
                        String location =
                            Get.find<LocationController>().getCurrentLocation();
                        return RichText(
                          textAlign: TextAlign.end,
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          text: TextSpan(
                            style: SettingsTextStyle(context),
                            text: location,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                //! notifications
                SettingsSection(title: "Notifications".tr),
                SettingsComps(
                    title: "Enable Notifications".tr,
                    icon: const Icon(Icons.notifications),
                    destination: () {
                      Get.to(const NotificationsPage());
                    }),
              ],
            ),
          ),
        ));
  }

  TextStyle SettingsTextStyle(BuildContext context) =>
      TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15);
}
