import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/main_page.dart';
import 'package:mamamia_uniproject/theme/theme_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar("Settings".tr),
      body: Center(
          child: Column(
        children: [
          const ListTile(
            title: Align(
                alignment: Alignment.centerLeft, child: ThemeToggleButton()),
          ),
          ProjectDivider(),
          //! changing the language button
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ListTile(
              leading: Icon(
                Icons.translate,
                color: MainPage.orangeColor,
              ),
              title: Text(
                "Change language".tr,
              ),
              onTap: () {
                Locale currentLocale = Get.locale ?? const Locale("en");
                Get.updateLocale(currentLocale.languageCode == "en"
                    ? const Locale("ar")
                    : const Locale("en"));
              },
            ),
          ),
          ProjectDivider()
        ],
      )),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ProjectDivider() {
    return Divider(
      indent: 15,
      endIndent: 15,
    );
  }
}
