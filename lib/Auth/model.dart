import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


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
  bool imageIspicked = false;
  var pickedImage;
  void changeImage(File pickedImage) {
    imageIspicked = true;
    this.pickedImage = Image.file(
      pickedImage,
      fit: BoxFit.contain,
    );
    update();
  }

  _openTwitter() async {
    const url = "https://x.com/";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  _openFaceBook() async {
    const url = "facebook.com/login/?next=https%3A%2F%2Fwww.facebook.com%2F";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  _openInstagram() async {
    var url = Uri.parse("https://www.instagram.com/");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //url_launcher Functions
  void UrlLauncher(String type) {
    if (type == "instagram") {
      _openInstagram();
    }
    if (type == "facebook") {
      _openFaceBook();
    }
    if (type == "twitter") {
      _openTwitter();
    }
  }
}
