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
//! to get token or u can use the shared
  Future<String?> getToken() async {
    tokenPref = await SharedPreferences.getInstance();
    return tokenPref!.getString('access_token');
  }
  //or use this tokenPref!.getString('access_token');

//!-#######################################(------Login------)#########################################
  Future<void> login(String password, String number) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.110:8000/api/auth/login'),
        body: {
          'password': password,
          'user_phone': number,
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
  Future<void> signUp(String name, String password, String number) async {
    try {
      final response = await http.post(
        Uri.parse(
          'http://192.168.1.110:8000/api/register?name=$name&password=$password&user_phone=$number',
        ),
        body: {
          'name': name,
          'password': password,
          'user_phone': number,
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
  Future<void> logOut() async {
    try {
      String? token = await getToken();
      final response = await http.post(
        Uri.parse(
          'http://192.168.1.110:8000/api/auth/logout?token=$token',
        ),
        body: {},
      );
      final decodedResponse = jsonDecode(response.body);
      // print('API Response: $decodedResponse');
      if (response.statusCode == 200) {
        print('logout test');
        print(token);
        Get.snackbar(
          "Success",
          "LogOut successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.off(const LoginPage());
        middleWarePref!.remove('id');
        userInfo!.remove("name");
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
          'http://192.168.1.110:8000/api/auth/refresh?token=$token',
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
// noo need for snack bars
  // Future<void> profileRequest() async {
  //   try {
  //     String? token = await getToken();
  //     final response = await http.post(
  //       Uri.parse(
  //         'http://10.0.2.2:8000/api/auth/me?$token',
  //       ),
  //       body: {},
  //     );
  //     final decodedResponse = jsonDecode(response.body);
  //     // print('API Response: $decodedResponse');
  //     if (response.statusCode == 200) {
  //       print(token);
  //       Get.snackbar(
  //         "Success",
  //         "Profile request ",
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.green,
  //         colorText: Colors.white,
  //       );
  //     } else {
  //       Get.snackbar(
  //         "Error",
  //         "An unexpected error occurred",
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //       );
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       "Exception",
  //       e.toString(),
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //     print('Error: $e');
  //   }
  // }

  /*
    //! api response
    "id": 2,
    "name": "mohammed",
    "email": null,
    "email_verified_at": null,
    "last_name": null,
    "user_location": null,
    "user_phone": "0987654321",
    "photo_path": null,
    "is_admin": 0,
    "language": "english",
    "created_at": "2025-01-01T12:24:01.000000Z",
    "updated_at": "2025-01-01T12:24:01.000000Z"
    //! should be taken to the profile page
  */

//$-#######################################(------edit Profile------)#############################################

  Future<void> editProfileRequest(String name, String lastName) async {
    try {
      //! location
      // maybe edit the toString()
      String userLocation =
          Get.find<LocationController>().getCurrentLocation().toString();
      //! token
      String? editProfileToken = await getToken();
      final response = await http.post(
        Uri.parse(
            'http://192.168.1.110:8000/api/auth/edit?name$name&last_name=$lastName&user_location=$userLocation&token=$editProfileToken'),
        body: {
          'name': name,
          'last_name': lastName,
          // 'user_location': userLocation,
          // i dont think i should pass the token like that
        },
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Changes updated ",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        print('Edit Profile tst');
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

      // Use your machine's IP address instead of 127.0.0.1
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://192.168.1.110:8000/api/auth/uploadImage?token=$tokenImg'),
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
          "Image uploaded successfully!",
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
