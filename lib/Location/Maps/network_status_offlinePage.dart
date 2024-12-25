import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:mamamia_uniproject/Location/Maps/map.dart';
import 'package:mamamia_uniproject/main_page.dart';

class NetworkStatus extends StatefulWidget {
  //! this is the class the determine that the scaffold going to show damn man or error message
  const NetworkStatus({super.key});

  @override
  State<NetworkStatus> createState() => _NetworkStatusState();
}

class _NetworkStatusState extends State<NetworkStatus> {
  bool isConnectedToInternet = false;

  StreamSubscription? _internetConnectionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            isConnectedToInternet = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            isConnectedToInternet = false;
          });
          break;
        // default:
        //   setState(() {
        //     isConnectedToInternet = false;
        //   });
        //   break;
      }
    });
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isConnectedToInternet
        ? const MapScreen()
        : Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                  onPressed: () {
                    Get.offAll(const MainPage());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Set Later"),
                  ),
                )
              ],
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Get
                            .isDarkMode //! its displaying the same lottie over and over and over fix that
                        ? Lottie.asset(
                            fit: BoxFit.cover,
                            'assets/animations/dinofordarktheme.json')
                        : Lottie.asset(
                            fit: BoxFit.cover,
                            'assets/animations/dinolightmode.json')),
                Text(
                  '  You\'re Offline :(',
                  style: TextStyle(
                    color: MainPage.orangeColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Please Make Sure You\'re Connected To The Internet',
                  style: TextStyle(
                    color: MainPage.orangeColor,
                  ),
                ),
              ],
            )),
          );
  }
}
