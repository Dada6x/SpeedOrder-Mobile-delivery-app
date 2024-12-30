import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/main_page.dart';

class NotificationsDrawer extends StatelessWidget {
  const NotificationsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications'.tr,
        ),
        shape:
            Border(bottom: BorderSide(color: MainPage.orangeColor, width: 1.2)),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('notification'),
          ),
          const ListTile(title: Text('notification')),
          const ListTile(title: Text('notification')),
          const ListTile(title: Text('notification')),
          const ListTile(title: Text('notification')),
          TextButton(onPressed: () {}, child: const Text('Clear')),
        ],
      ),
    );
  }
}
