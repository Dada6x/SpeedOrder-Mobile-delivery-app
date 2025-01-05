import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';
import 'package:mamamia_uniproject/Location/setLocation.dart';
import 'package:mamamia_uniproject/main.dart';
import 'package:mamamia_uniproject/main_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Model extends GetxController {
  final String baseUrl = "http://192.168.43.44:8000/api";

  Model();
//!-#######################################(------Login------)#########################################
  Future<void> login(String password, String number) async {
    try {
      final response = await http.post(
        Uri.parse(
            //! change the ip if emulator
            // emulator :10.0.2.2
            // physical device  the normal ip if host ⟶ ipv4 if apache 127.0.0.1
            'http://10.0.2.2:8000/api/auth/login?password=$password&user_phone=$number'),
        body: {
          'password': password,
          'user_phone': number,
        },
      );
      final decodedResponse = jsonDecode(response.body);
      print('API Responsssse: $decodedResponse');
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Welcome Back",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        //! going to mainPage and active
        Get.off(() => const MainPage());
        sharedPref!.setString("id", "1");
        // the token
        print('API Response: $decodedResponse');
      } else {
        // Check for specific error messages like 'user_phone'
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('error')) {
          Get.snackbar(
            "Error",
            decodedResponse['error'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else {
          // Generic error message
          Get.snackbar(
            "Error",
            "An unexpected error occurred",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
      // the response
    } catch (e) {
      Get.snackbar(
        "Exception",
        messageText: Text("${jsonEncode(e)}"),
        "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error: $e');
    }
  }

//!-#######################################(------SignUp------)#########################################
  Future<void> signUp(String name, String password, String number) async {
    try {
      final response = await http.post(
        Uri.parse(
          'http://10.0.2.2:8000/api/register?name=$name&password=$password&user_phone=$number',
        ),
        body: {
          'name': name,
          'password': password,
          'user_phone': number,
        },
      );

      final decodedResponse = jsonDecode(response.body);
      print('API Response: $decodedResponse');

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Signup Successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
        Get.off(const SettingLocation());
        sharedPref!.setString("id", "1");
      } else {
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('user_phone')) {
          Get.snackbar(
            "Error",
            decodedResponse['user_phone'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            "Error",
            "An unexpected error occurred",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        "Exception",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error: $e');
    }
  }

//!-#######################################(------LogOut------)#########################################

  Future<void> logOut(String token) async {
    try {
      final response = await http.post(
        Uri.parse(
          'http://10.0.2.2:8000/api/auth/logout?token=$token',
        ),
        body: {
          'token': token,
        },
      );
      final decodedResponse = jsonDecode(response.body);
      print('API Response: $decodedResponse');
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "LogOut successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.off(const LoginPage());
        sharedPref!.remove('id');
      } else {
        // Check for specific error messages like 'user_phone'
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('user_phone')) {
          Get.snackbar(
            "Error",
            decodedResponse['user_phone'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else {
          // Generic error message
          Get.snackbar(
            "Error",
            "An unexpected error occurred",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        "Exception",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error: $e');
    }
  }

//!-#######################################(------UploadImage------)#########################################
// requires token
// there is a file in the body of this request

//!-#######################################(------Change Password ------)#########################################
//! url launcher
  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url.trim());
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $url');
    }
  }

  Future<void> openTwitter() async => _openUrl("https://x.com/");
  Future<void> openFacebook() async => _openUrl("https://facebook.com/");
  Future<void> openInstagram() async => _openUrl("https://www.instagram.com/");

  void urlLauncher(String type) {
    switch (type) {
      case "instagram":
        openInstagram();
        break;
      case "facebook":
        openFacebook();
        break;
      case "twitter":
        openTwitter();
        break;
      default:
    }
  }

//! IMP
  bool imageIsPicked = false;
  ImageProvider? pickedImage;

  void changeImage(File pickedImage) {
    imageIsPicked = true;
    this.pickedImage = Image(image: FileImage(pickedImage)).image;
    print("Image is picked");
    update();
  }
}
