import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/SignUpPage.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/components/categories_icons.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/main_page.dart';
import 'package:mamamia_uniproject/Auth/model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => SigninPageState();
}

class SigninPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  List userList = [
    {"number": "0931754165", "pass": "ward"}
  ];
  String? enteredNumber;
  String? enteredPass;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Model(),
        builder: (controller) => Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: NormalAppBar("Welcome !"),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 8.0, right: 15, left: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: controller.screenHeight(context) * 0.015,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          "SpeedOrder",
                          style: TextStyle(
                              color: MainPage.orangeColor,
                              fontWeight: FontWeight.w800,
                              fontSize:
                                  controller.screenWidth(context) * 0.155),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Where Quality and Efficiency Meet.",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Form(
                          key: formkey,
                          child: TextFormField(
                            validator: (val) {
                              if (val!.length >= 2) {
                                if (val[0] != '0' && val[1] != '9') {
                                  return "Number Should Start with \"09\"";
                                }
                              }
                              if (val.length != 10 && val.isNotEmpty) {
                                return "Input should be 10 numbers";
                              }
                              return null;
                            },
                            onChanged: (val) {
                              enteredNumber = val;
                              formkey.currentState!.validate();
                            },
                            maxLength: 10,
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                                fillColor: MainPage.greyColor,
                                filled: true,
                                labelText: "Enter Number",
                                labelStyle: const TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MainPage.greyColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MainPage.greyColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                )),
                          )),
                      SizedBox(
                        height: controller.screenHeight(context) * 0.015,
                      ),
                      Form(
                          child: TextFormField(
                        onChanged: (val) {
                          enteredPass = val;
                        },
                        decoration: InputDecoration(
                            fillColor: MainPage.greyColor,
                            filled: true,
                            labelText: "Enter Password",
                            labelStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: MainPage.greyColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: MainPage.greyColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            )),
                      )),
                      // SizedBox(
                      //   height: controller.screenHeight(context) * 0.03,
                      // ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Divider(),
                              ),
                            ),
                            Text('Our Socials'),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Divider(),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ProjectCategoriesIconsWithoutLabel(
                              icon: FontAwesomeIcons.facebook,
                            ),
                            ProjectCategoriesIconsWithoutLabel(
                              icon: FontAwesomeIcons.instagram,
                            ),
                            ProjectCategoriesIconsWithoutLabel(
                              icon: FontAwesomeIcons.whatsapp,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: controller.screenHeight(context) * 0.02,
                      ),
                      ProjectButton(
                        text: "Sign in ",
                        width: controller.screenWidth(context),
                        function: () {
                          Get.off(const MainPage());
                        },
                      ),

                      SizedBox(
                        height: controller.screenHeight(context) * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don`t Have an Account?",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.off(const SignupPage());
                            },
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  color: MainPage.orangeColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
