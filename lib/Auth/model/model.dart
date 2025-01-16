import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';
import 'package:mamamia_uniproject/Controllers/locationController_map.dart';
import 'package:mamamia_uniproject/Controllers/userController.dart';
import 'package:mamamia_uniproject/Location/setLocation.dart';
import 'package:mamamia_uniproject/main.dart';
import 'package:mamamia_uniproject/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Model extends GetxController {
  Model();
  Future<String?> getToken() async {
    tokenPref = await SharedPreferences.getInstance();
    return tokenPref!.getString('access_token');
  }
//0996385274

//@ 10.0.2.2 for the localHost
  //!(------Log in------)
  Future<void> loginRequest(String password, String number) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.1.6:8000/api/auth/login?password=$password&user_phone=$number'),
        body: {},
      );
      final decodedResponse = jsonDecode(response.body);
      // print('API Response: $decodedResponse');
      if (response.statusCode == 200) {
        String accessToken = decodedResponse['access_token'];
        tokenPref = await SharedPreferences.getInstance();
        await tokenPref!.setString('access_token', accessToken);
        Get.snackbar(
          "Success".tr,
          "Welcome Back".tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.off(() => const MainPage());
        middleWarePref!.setString("id", "1");
        print(tokenPref!.getString('access_token'));
      } else {
        // Handle error
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('error')) {
          Get.snackbar(
            "Error".tr,
            decodedResponse['error'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            "Error",
            "An Unexpected Error Occurred".tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        "Exception",
        messageText: Text(jsonEncode(e)),
        "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error: $e');
    }
  }

  //$(------Sign Up------)
  Future<void> signUpRequest({
    required String firstName,
    required String lastName,
    required String password,
    required String number,
    File? image,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'http://192.168.1.6:8000/api/register?name=$firstName&last_name=$lastName&password=$password&user_phone=$number',
        ),
      );

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'photo',
            image.path,
          ),
        );
      }

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String signUpAccessToken = decodedResponse['access_token'];
        final tokenPref = await SharedPreferences.getInstance();
        //! Setting the token
        await tokenPref.setString('access_token', signUpAccessToken);
        Get.snackbar(
          "Success".tr,
          "Signup Successfully".tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        //! Middleware
        Get.off(() => const SettingLocation());
        //used to be mainpage
        print('signup test');
        final middleWarePref = await SharedPreferences.getInstance();
        middleWarePref.setString("id", "1");
      } else {
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('user_phone')) {
          Get.snackbar(
            "Error".tr,
            decodedResponse['user_phone'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            "Error".tr,
            "An Unexpected Error Occurred".tr,
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

  //!(------Log Out------)
  Future<void> logOutRequest() async {
    try {
      String? token = await getToken();
      final response = await http.post(
        Uri.parse(
          'http://192.168.1.6:8000/api/auth/logout?token=$token',
        ),
        body: {},
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Logout successfully we'll miss you".tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.off(const LoginPage());
        middleWarePref!.remove('id');
        userInfo!.remove("first_name");
        userInfo!.remove("last_name");
        userInfo!.remove("number");
        userInfo!.remove("photo");
        eraseImage();
      } else {
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('user_phone')) {
          Get.snackbar(
            "Error".tr,
            decodedResponse['user_phone'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            "Error".tr,
            "An Unexpected Error Occurred".tr,
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

//!(------Profile--------)
  Future<void> profileRequest() async {
    try {
      String? token = await getToken();
      final response = await http.post(
        Uri.parse('http://192.168.1.6:8000/api/auth/me?token=$token'),
        body: {},
      );
      final decodedResponse = jsonDecode(response.body);
      print('profile request  test : $decodedResponse');
      print('Saved image path: ${decodedResponse['photo_path']}');
      userInfo!.setString("photo", decodedResponse['photo_path']);
      if (response.statusCode == 200) {
        userInfo?.setString("first_name", decodedResponse['name']);
        userInfo?.setString("last_name", decodedResponse['last_name']);
        userInfo?.setString("number", decodedResponse['user_phone']);

        Get.find<UserController>().updateFirstName();
        Get.find<UserController>().updateLastName();
      } else {}
    } catch (e) {
      print('Exception: $e');
    }
  }

//$ ########(------edit Profile------)######
//@ First Name
  Future<void> editUserFirstNameRequest(String firstName) async {
    try {
      String? editProfileToken = await getToken();
      final response = await http.post(
        Uri.parse('http://192.168.1.6:8000/api/auth/edit'),
        body: {
          'name': firstName,
          'token': editProfileToken,
        },
      );
      // final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success".tr,
          "First name updated successfully".tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // the user successfully updated the name
        userInfo?.setString("first_name", firstName);
        Get.find<UserController>().updateFirstName();
      } else {
        Get.snackbar(
          "Error".tr,
          'eeee',
          // decodedResponse['error'].toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Exception",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

//@ LastName
  Future<void> editUserLastNameRequest(String lastName) async {
    try {
      String? editProfileToken = await getToken();
      final response = await http.post(
        Uri.parse(
            'http://192.168.1.6:8000/api/auth/edit?last_name=$lastName&token=$editProfileToken'),
        body: {
          'name': userInfo!.getString("first_name").toString(),
          'last_name': lastName
        },
      );
      // final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success".tr,
          "  Last Name Changes updated ",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // the user successfully updated the last name
        userInfo?.setString("last_name", lastName);
        Get.find<UserController>().updateFirstName();
        print('Edit name tst');
      } else {
        Get.snackbar(
          "Error".tr,
          'weeeee',
          // decodedResponse['error'].toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Exception",
        messageText: Text(jsonEncode(e)),
        "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

//@ LOCATION
  Future<void> editUserLocationRequest() async {
    try {
      //! location
      String userLocation =
          Get.find<LocationController>().getCurrentLocation().toString();
      //! token
      String? editProfileToken = await getToken();
      final response = await http.post(
        Uri.parse(
            'http://192.168.1.6:8000/api/auth/edit?user_location=$userLocation&token=$editProfileToken'),
        body: {
          // i know its false but i🇩🇰
          'name': userInfo!.getString("first_name").toString(),
        },
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success".tr,
          " name Changes updated ",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        print('Edit name tst');
      } else {
        Get.snackbar(
          "Error".tr,
          decodedResponse['error'].toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Exception",
        messageText: Text(jsonEncode(e)),
        "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  //!(------Upload image---------)
  Future<void> uploadImageRequest(File image) async {
    try {
      String? tokenImg = await getToken();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://192.168.1.6:8000/api/auth/uploadImage?token=$tokenImg'),
      );

      // Add the image file to the request
      request.files.add(await http.MultipartFile.fromPath(
        'photo',
        image.path,
      ));
      // Send the request
      var response = await request.send();

      // Read the response
      var responseBody = await response.stream.bytesToString();

      // Log the response status and body
      print('Status Code: ${response.statusCode}');
      userInfo!.setString("photo", responseBody);

      if (response.statusCode == 200) {
        print('uploaded image path tst: $responseBody');

        // profileRequest();
        userInfo!.setString("photo", responseBody);

        Get.snackbar(
          "Success".tr,
          "Image uploaded successfully!, Looks Great",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error".tr,
          "An unexpected error occurred: ${response.statusCode}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
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

  //$(------Change Password------)
  Future<void> editUserPasswordRequest(
      String userPhone, String oldPassword, String newPassword) async {
    try {
      //! token
      String? editProfileToken = await getToken();
      final response = await http.post(
        Uri.parse(
            'http://192.168.1.6:8000/api/auth/change_password?user_phone=$userPhone&password=$oldPassword&new_password=$newPassword&token=$editProfileToken'),
        body: {},
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success".tr,
          "Password Changed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error".tr,
          "An Unexpected Error Occurred".tr,
          // decodedResponse['error'].toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Exception",
        messageText: Text(jsonEncode(e)),
        "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

//$(------Refresh------)
  Future<void> refreshRequest() async {
    try {
      String? token = await getToken();
      final response = await http.post(
        Uri.parse(
          'http://192.168.1.6:8000/api/auth/refresh?token=$token',
        ),
        body: {},
      );
      if (response.statusCode == 200) {
        print(token);
        Get.snackbar(
          "Success",
          "refresh successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
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

//$-#######################################(------  ------)#########################################

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

  //! image Picker

  RxBool imageIsPicked = false.obs;
  Rx<ImageProvider?> pickedImage = Rx<ImageProvider?>(null);

  void changeImage(File pickedImageFile) {
    imageIsPicked.value = true;
    pickedImage.value = FileImage(pickedImageFile);

    print("Image is picked");
  }

  void eraseImage() {
    imageIsPicked.value = false;
    pickedImage.value = null;
    print("Image is erased");
  }
}
