import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/help_center.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/settings_page.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/main_page.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';

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
          const CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage(''),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('User Name'.tr),
              IconButton(
                  onPressed: () {
                    Get.bottomSheet(Container(
                      //! fix the bug when the keyboard everything overflows
                      color: Theme.of(context).colorScheme.secondary,
                      height: 600,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const TextField(),
                            const CircleAvatar(
                              //  i think showing the image is not necessary so
                              // so im putting button later
                              radius: 90,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text('Cancel'.tr)),
                                ElevatedButton(
                                    onPressed: () {
                                      //! update the user Name
                                    },
                                    child: Text('Save'.tr))
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
                    //! Image Picker########## above ##############
                    //! username changer############
                  },
                  icon: Icon(
                    Icons.edit,
                    color: MainPage.orangeColor,
                  ))
            ],
          ),
          Divider(
            color: MainPage.orangeColor,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  //! logOutButton kick the user out
                  Get.off(const LoginPage());
                },
                label: Text(
                  'Log out'.tr,
                ),
                icon: Icon(
                  Icons.login_rounded,
                  color: MainPage.orangeColor,
                ),
              ),
              //! theme toggle button
            ],
          ),
        ],
      ),
    );
  }
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
        iconColor: MainPage.orangeColor,
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
