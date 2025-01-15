import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
      body: Column(
        children: [
          Container(
              child: Lottie.asset("assets/animations/amogus.json",
                  )),
          Center(
              child: Text(
            "Coming Soon...",
            style: TextStyle(
              fontSize: 35,
              color: Theme.of(context).colorScheme.primary,
            ),
          ))
        ],
      ),
    );
  }
}
