import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:mamamia_uniproject/Location/maps/CurrentLoaction/current_location_map.dart';
import 'package:mamamia_uniproject/Location/maps/manuallLocation/map.dart';
import 'package:mamamia_uniproject/main_page.dart';

class Networkstatus2 extends StatefulWidget {
  //! this is the class the determine that the scaffold going to show damn man or error message
  const Networkstatus2({super.key});

  @override
  State<Networkstatus2> createState() => _NetworkStatusState();
}

class _NetworkStatusState extends State<Networkstatus2> {
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
        ? const Currentlocationmap()
        : Scaffold(
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
              ],
            )),
          );
  }
}
