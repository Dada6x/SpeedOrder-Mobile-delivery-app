import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Model extends GetxController {
  get logged => loggedin;
  bool loggedin = false;
  Model() {
    checkLoginStatus();
  }
  Future<bool?> checkLoginStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loggedin = sp.getBool("login") ?? false;
    update();
    return null;
  }

  Future<bool?> Logintrue() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loggedin = true;
    sp.setBool("login", true);
    update();
    return null;
  }

  Future<bool?> Loginfalse() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loggedin = false;
    sp.setBool("login", false);
    update();
    return null;
  }

  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // ignore: non_constant_identifier_names
  int Buttonindex = -1;
  Image pickedImage = Image.asset("images/addpfp.jpg");
  void changeImage(File pickedImage) {
    this.pickedImage = Image.file(pickedImage);
    update();
    print("image has change !!!!!!!!");
  }
}
