import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/image_picker/image_picker.dart';
import 'package:mamamia_uniproject/main.dart';

// import 'dart:convert';
// import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignupPage> {
//$-------------------------Controllers-----------------------
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
//$-----------------------------------------------------------
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  Image? img;
  String? enteredNumber;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Model>(
      builder: (controller) {
        return Scaffold(
          appBar: NormalAppBar('Enter your info'.tr),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  //! image
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight(context) * 0.02,
                    ),
                    child: SizedBox(
                      width: 135,
                      height: 150,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const ImagePickingDialog();
                              });
                        },
                        child: Get.find<Model>().imageIsPicked
                            ? CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                backgroundImage: Get.find<Model>().pickedImage,
                              )
                            : CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                child: const Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                  //! first name
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight(context) * 0.01,
                    ),
                    child: TextField(
                      controller: firstNameController,
                      decoration: inputDecoration(
                          isPassword: false,
                          context: context,
                          hint: "First name",
                          //make trim
                          icon: const Icon(Icons.person, color: Colors.grey)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight(context) * 0.03,
                    ),
                    child: TextField(
                      controller: lastNameController,
                      decoration: inputDecoration(
                          isPassword: false,
                          context: context,
                          hint: "Last Name",
                          icon: const Icon(Icons.person_outline,
                              color: Colors.grey)),
                    ),
                  ),
                  //! phone Number
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight(context) * 0.03,
                    ),
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Number is required";
                          }
                          if (val.length != 10) {
                            return "Input should be 10 numbers";
                          }
                          if (!val.startsWith('09')) {
                            return "Number should start with '09'";
                          }
                          return null;
                        },
                        onChanged: (val) {
                          enteredNumber = val;
                          formKey.currentState!.validate();
                        },
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: inputDecoration(
                          isPassword: false,
                          context: context,
                          hint: "Enter Number",
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                        ),
                        controller: numberController,
                      ),
                    ),
                  ),
                  //! Password
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: screenHeight(context) * 0.05,
                      top: screenHeight(context) * 0.03,
                    ),
                    child: TextField(
                        maxLength: 24,
                        obscureText: !isPasswordVisible,
                        controller: passwordController,
                        decoration: inputDecoration(
                            isPassword: true,
                            context: context,
                            hint: "Password",
                            icon: const Icon(
                              Icons.key,
                              color: Colors.grey,
                            ))),
                  ),
                  //! register button
                  ProjectButton(
                    text: 'Next'.tr,
                    width: screenWidth(context),
                    function: () {
                      if (firstNameController.text.isEmpty ||
                          lastNameController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          numberController.text.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "All fields are required!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      } else if (formKey.currentState?.validate() == false) {
                        Get.snackbar(
                          "Error",
                          "Please insert 10 numbers ",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      } else {
                        controller.signUpRequest(
                            firstNameController.text,
                            lastNameController.text,
                            passwordController.text,
                            numberController.text);

                        // userInfo?.setString(
                        //     "first_name", firstNameController.text);
                        // userInfo?.setString(
                        //     "last_name", firstNameController.text);
                        // userInfo?.setString("number", numberController.text);
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account ?".tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.off(() => const LoginPage());
                        },
                        child: Text(
                          "Log in".tr,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  InputDecoration inputDecoration({
    required bool isPassword,
    required BuildContext context,
    required String hint,
    required Icon icon,
  }) {
    return InputDecoration(
      fillColor: Theme.of(context).colorScheme.secondary,
      filled: true,
      prefixIcon: icon,
      suffixIcon: isPassword
          ? IconButton(
              color: Colors.grey[800],
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              icon: isPasswordVisible
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility))
          : null,
      iconColor: Colors.grey,
      hintText: hint.tr,
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}

//!
/*
// not all fields are filled 
image picker is optional 
// starts with 09
// password max 24
local host for emulator is 10.0.2.2
show messages for 
                  taken phone number 
                  user already exist
                  network error 
                  success\
  the body of the request is user_phone //! the errors
token
*/

//! yahea : image picker needs to be in independent class
//! yahea : Done baby i got you(myself),
//help me im going insane :P
