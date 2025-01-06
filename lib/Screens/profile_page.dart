import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/Settings/settings_page.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/help_center.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';
import 'package:mamamia_uniproject/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar('Profile'.tr),
      body: Column(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: Get.find<Model>().pickedImage,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('User Name'.tr),
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.primary,
            indent: 15,
            endIndent: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                MenuListItem(
                  title: 'Settings'.tr,
                  icon: const Icon(Icons.settings),
                  destination: () {
                    Get.to(const SettingsPage());
                  },
                ),
                MenuListItem(
                  title: 'Order History'.tr,
                  icon: const Icon(Icons.date_range),
                  destination: () {
                    //! make order history
                  },
                ),
                MenuListItem(
                  title: 'Help Center'.tr,
                  icon: const Icon(Icons.help),
                  destination: () {
                    Get.to(const HelpCenter());
                  },
                ),
                MenuListItem(
                  title: 'Account Details'.tr,
                  icon: const Icon(Icons.auto_graph_rounded),
                  destination: () {
                    //! make account details
                  },
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: () {
              //! logOutButton
              logOut();
              // Get.off(const LoginPage());
              // middleWarePref!.remove('id'); // Clear only the login-related data

              //ward: changed it cuz older one had an arrow back button
              //yahea: np baby
            },
            label: Text(
              'Log out'.tr,
            ),
            icon: Icon(Icons.login_rounded,
                color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }

  //@ the used item in the list of settings
}

class MenuListItem extends StatelessWidget {
  final String title;
  final Icon? icon;
  final Function destination;
  const MenuListItem(
      {super.key, required this.title, this.icon, required this.destination});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Theme.of(context).colorScheme.secondary,
      child: ListTile(
        onTap: () => destination(),
        iconColor: Theme.of(context).colorScheme.primary,
        title: Text(title),
        leading: icon,
        trailing: const Icon(
          Icons.chevron_right,
          size: 27,
        ),
      ),
    );
  }
}

Future<void> logOut() async {
  try {
    final response = await http.post(
      Uri.parse(
        'http://10.0.2.2:8000/api/auth/logout?token=$tokenPref',
      ),
      body: {},
    );
    final decodedResponse = jsonDecode(response.body);
    print('API Response: $decodedResponse');
    if (response.statusCode == 200) {
      Get.snackbar(
        "Success",
        "LogOut successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.off(const LoginPage());
      middleWarePref!.remove('id');
    } else {
      // Check for specific error messages like 'user_phone'
      if (decodedResponse is Map<String, dynamic> &&
          decodedResponse.containsKey('user_phone')) {
        Get.snackbar(
          "Error",
          decodedResponse['user_phone'].toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        // Generic error message
        Get.snackbar(
          "Error",
          "An unexpected error occurred",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  } catch (e) {
    Get.snackbar(
      "Exception",
      e.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    print('Error: $e');
  }
}
