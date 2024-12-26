import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsDrawer extends StatelessWidget {
  const NotificationsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications'.tr,
        ),
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
