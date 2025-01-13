import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';
import 'package:mamamia_uniproject/Controllers/locationController_map.dart';
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
  //or use this tokenPref!.getString('access_token');

//!-#######################################(------Login------)#########################################
  Future<void> loginRequest(String password, String number) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://10.0.2.2:8000/api/auth/login?password=$password&user_phone=$number'),
        body: {
          // 'password': password,
          // 'user_phone': number,
        },
      );
      final decodedResponse = jsonDecode(response.body);
      // print('API Response: $decodedResponse');
      if (response.statusCode == 200) {
        String accessToken = decodedResponse['access_token'];
        tokenPref = await SharedPreferences.getInstance();
        await tokenPref!.setString('access_token', accessToken);
        Get.snackbar(
          "Success",
          "Welcome Back",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Navigate to the main page
        Get.off(() => const MainPage());
        middleWarePref!.setString("id", "1");
        // print('API Response: $decodedResponse');
        print('Login test');
        print(tokenPref!.getString('access_token'));
      } else {
        // Handle error
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
        messageText: Text(jsonEncode(e)),
        "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error: $e');
    }
  }

//$-#######################################(------SignUp------)#########################################
  Future<void> signUpRequest(
      String name, String password, String number) async {
    try {
      final response = await http.post(
        Uri.parse(
          'http://10.0.2.2:8000/api/register?name=$name&password=$password&user_phone=$number',
        ),
        body: {
          // 'name': name,
          // 'password': password,
          // 'user_phone': number,
        },
      );

      final decodedResponse = jsonDecode(response.body);
      // print('API Response: $decodedResponse');

      if (response.statusCode == 200) {
        //! if login
        String signUpAccessToken = decodedResponse['access_token'];
        tokenPref = await SharedPreferences.getInstance();
        await tokenPref!.setString('access_token', signUpAccessToken);
        Get.snackbar(
          "Success",
          "Signup Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.off(() => const MainPage());
        middleWarePref!.setString("id", "1");
        // print('API Response: $decodedResponse');
        print('signup test');
        print(tokenPref!.getString('access_token'));
      } else {
        //! Handle error
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
  Future<void> logOutRequest() async {
    try {
      String? token = await getToken();
      final response = await http.post(
        Uri.parse(
          'http://10.0.2.2:8000/api/auth/logout?token=$token',
        ),
        body: {},
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // print('logout test');
        // print(token);
        Get.snackbar(
          "Success",
          "LogOut successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.off(const LoginPage());
        middleWarePref!.remove('id');
        userInfo!.remove("first_name");
        userInfo!.remove("last_name");
        userInfo!.remove("number");
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

//$-#######################################(------Refresh------)#########################################
  Future<void> refreshRequest() async {
    //TODO  why the hell refresh give me token ??

    try {
      String? token = await getToken();
      final response = await http.post(
        Uri.parse(
          'http://10.0.2.2:8000/api/auth/refresh?token=$token',
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

//!-#######################################(------Profile------)#########################################

  Future<void> profileRequest() async {
    try {
      String? token = await getToken();
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/auth/me?token=$token'),
        body: {},
      );

      final decodedResponse = jsonDecode(response.body);
      print('profile request  test : $decodedResponse');

      if (response.statusCode == 200) {
        // String name = decodedResponse['name'];
        // String userPhone = decodedResponse['user_phone'];
        // String lastName = decodedResponse['last_name'];
        userInfo?.setString("first_name", decodedResponse['name']);
        userInfo?.setString("number", decodedResponse['user_phone']);
        userInfo?.setString("last_name", decodedResponse['last_name']);
        // print('Name: $name');
        // print('Phone: $userPhone');
        // print("LastName:$lastName ");
      } else {}
    } catch (e) {
      print('Exception: $e');
    }
  }

  //! api response
  /*
    "name": "mohammed",
    "last_name": null,
    "user_location": null,
    "user_phone": "0987654321",
    "photo_path": null,
    //! file
  */

//$-#######################################(------edit Profile------)###############################################
//@ First Name
  Future<void> editUserFirstNameRequest(String firstName) async {
    try {
      String? editProfileToken = await getToken();
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/auth/edit'),
        body: {
          'name': firstName,
          'token': editProfileToken,
        },
      );
      // final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "First name updated successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // the user successfully updated the name
        userInfo?.setString("first_name", firstName);
      } else {
        Get.snackbar(
          "Error",
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
            'http://10.0.2.2:8000/api/auth/edit?last_name=$lastName&token=$editProfileToken'),
        body: {
          'name': userInfo!.getString("first_name").toString(),
          'last_name': lastName
        },
      );
      // final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "  Last Name Changes updated ",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // the user successfully updated the last name
        userInfo?.setString("last_name", lastName);
        print('Edit name tst');
      } else {
        Get.snackbar(
          "Error",
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
            'http://10.0.2.2:8000/api/auth/edit?user_location=$userLocation&token=$editProfileToken'),
        body: {
          // i know its false but i🇩🇰
          'name': userInfo!.getString("first_name").toString(),
        },
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          " name Changes updated ",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        print('Edit name tst');
      } else {
        Get.snackbar(
          "Error",
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

//!-#######################################(------UploadImage------)##############################################
  Future<void> uploadImageRequest(File image) async {
    try {
      String? tokenImg = await getToken();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8000/api/auth/uploadImage?token=$tokenImg'),
      );

      // Add the image file to the request
      request.files.add(await http.MultipartFile.fromPath(
        'photo', // This should match the key expected by your server
        image.path,
      ));

      // Send the request
      var response = await request.send();

      // Read the response
      var responseBody = await response.stream.bytesToString();

      // Log the response status and body
      print('Status Code: ${response.statusCode}');
      print('Response Body: $responseBody');

      // Check the response status
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Image uploaded successfully!, Looks Great",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
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

//$-#######################################(------Change Password ------)#########################################
  Future<void> editUserPasswordRequest(
      String userPhone, String oldPassword, String newPassword) async {
    try {
      //! token
      String? editProfileToken = await getToken();
      final response = await http.post(
        Uri.parse(
            'http://10.0.2.2:8000/api/auth/change_password?user_phone=$userPhone&password=$oldPassword&new_password=$newPassword&token=$editProfileToken'),
        body: {},
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Password Changed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          " Something Went Wrong ",
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
  bool imageIsPicked = false;
  ImageProvider? pickedImage;
  void changeImage(File pickedImage) {
    imageIsPicked = true;
    this.pickedImage = Image(image: FileImage(pickedImage)).image;
    print("Image is picked");
    update();
  }
}
