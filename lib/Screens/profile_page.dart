import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/help_center.dart';
import 'package:mamamia_uniproject/Screens/settings/settings_page.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
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
                  icon: Icon(Icons.edit,
                      color: Theme.of(context).colorScheme.primary))
            ],
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
                    Get.to(SettingsPage());
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
                  title: 'FAQ'.tr,
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
              Get.off(
                  const LoginPage()); //ward: changed it cuz older one had an arrow back button
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
