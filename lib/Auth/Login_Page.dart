import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/SignUpPage.dart';
import 'package:mamamia_uniproject/Auth/validation/forgetPassword.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/components/language_toggle_button_icon.dart';
import 'package:mamamia_uniproject/components/ourSocials.dart';
import 'package:mamamia_uniproject/components/themSwitcher.dart';
import 'package:mamamia_uniproject/main.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/theme/themes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //!-------------------controllers--------------------------
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  //!--------------------------------------------------------

  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  String? enteredNumber;
  String? enteredPass;

  var darkTheme = Themes().darkMode;
  var lightTheme = Themes().lightMode;

  // Extracted validation logic
  String? _validatePhoneNumber(String? val) {
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
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Model>(
      builder: (controller) => ThemeSwitchingArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              "Welcome !".tr,
              style: const TextStyle(fontSize: 30),
            ),
            actions: [
              telegramSwitchButton(),
              const LanguageToggleButtonIcon(),
            ],
          ),
          body: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
              child: Column(
                children: [
                  SizedBox(height: screenHeight(context) * 0.015),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "SpeedOrder",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: screenWidth(context) * 0.155,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Where Quality and Efficiency Meet.".tr,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  //! NUMBER TEXT FIELD
                  Form(
                    key: formKey,
                    child: TextFormField(
                      validator: _validatePhoneNumber,
                      onChanged: (val) {
                        enteredNumber = val;
                        formKey.currentState!.validate();
                      },
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: inputDecoration(
                        isPassword: false,
                        context: context,
                        hint: "Enter Number",
                        icon: const Icon(Icons.phone),
                      ),
                      controller: numberController,
                    ),
                  ),
                  SizedBox(height: screenHeight(context) * 0.015),
                  //! Password
                  TextFormField(
                    obscureText: !isPasswordVisible,
                    decoration: inputDecoration(
                      isPassword: true,
                      context: context,
                      hint: "Enter Password",
                      icon: const Icon(Icons.key),
                    ),
                    controller: passwordController,
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Get.to(CodeVerificationPage());
                          },
                          child: const Text(
                            'Forget Password',
                            style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //! Social Media Links
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Divider(),
                          ),
                        ),
                        Text('Our Socials'.tr),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight(context) * 0.01),
                  const Oursocials(),
                  SizedBox(height: screenHeight(context) * 0.02),
                  ProjectButton(
                    text: "Log in".tr,
                    width: screenWidth(context),
                    function: () {
                      //! LOGIN
                      if (passwordController.text.isEmpty ||
                          numberController.text.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "All fields are required !",
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
                        controller.loginRequest(
                          passwordController.text,
                          numberController.text,
                        );

                        // userInfo?.setString("number", numberController.text);
                      }
                    },
                  ),
                  SizedBox(height: screenHeight(context) * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don`t Have an Account?".tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.off(const SignupPage());
                        },
                        child: Text(
                          "Sign Up".tr,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration({
    required BuildContext context,
    required String hint,
    required Icon icon,
    required bool isPassword,
  }) {
    return InputDecoration(
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
                  : const Icon(Icons.visibility),
            )
          : null,
      fillColor: Theme.of(context).colorScheme.secondary,
      filled: true,
      prefixIcon: icon,
      labelText: hint.tr,
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
