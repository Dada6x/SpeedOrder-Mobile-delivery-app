// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/SignUpPage.dart';
// import 'package:mamamia_uniproject/Auth/model.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/FAQ/FAQ_page.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/Orders/orders_page.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/Settings/settings_page.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

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
          Stack(children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: Get.find<Model>().pickedImage,
            ),
            Positioned(
                bottom: 1,
                right: -10,
                height: 50,
                child: RawMaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const ImagePickingDialog();
                        });
                  },
                  elevation: 2.0,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.all(15.0),
                  shape: const CircleBorder(),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )),
          ]),
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
                    Get.to(const OrdersPage());
                  },
                ),
                MenuListItem(
                  title: 'FAQ'.tr,
                  icon: const Icon(Icons.help),
                  destination: () {
                    Get.to(const FAQPage());
                  },
                ),
                // MenuListItem(
                //   title: 'Account Details'.tr,
                //   icon: const Icon(Icons.auto_graph_rounded),
                //   destination: () {
                //     //! make account details
                //   },
                // ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: () {
              Get.find<Model>().logOut();
              //! maybe i should delete the token
            },
            label: Text(
              'Log out'.tr,
            ),
            icon: Icon(Icons.logout_outlined,
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
