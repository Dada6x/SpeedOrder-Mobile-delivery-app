import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mamamia_uniproject/SignUpPage.dart';
import 'package:mamamia_uniproject/model.dart';

class Sign_in_Page extends StatefulWidget {
  const Sign_in_Page({super.key});

  @override
  State<Sign_in_Page> createState() => _sp();
}

class _sp extends State<Sign_in_Page> {
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
              appBar: AppBar(
                title: const Text(
                  "Welcome !",
                  style: TextStyle(fontSize: 25),
                ),
                elevation: 0,
                shadowColor: Colors.black,
              ),
              body: Padding(
                padding: EdgeInsets.only(
                  top: controller.screenHeight(context) * 0.13,
                  left: controller.screenWidth(context) * 0.1,
                  right: controller.screenWidth(context) * 0.1,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        overflow: TextOverflow.clip,
                        "SpeedOrder",
                        style: TextStyle(
                            color: const Color(0xFFEC6335),
                            fontWeight: FontWeight.w800,
                            fontSize: controller.screenHeight(context) * 0.065),
                      ),
                      SizedBox(
                        height: controller.screenHeight(context) * 0.005,
                      ),
                      const Text(
                        "Where Quality and Efficiency Meet.",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: controller.screenHeight(context) * 0.03,
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
                            decoration: const InputDecoration(
                                fillColor: Color(0xFF191919),
                                filled: true,
                                labelText: "Enter Number",
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF191919)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF191919)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                        decoration: const InputDecoration(
                            fillColor: Color(0xFF191919),
                            filled: true,
                            labelText: "Enter PassWord",
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF191919)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF191919)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      )),
                      SizedBox(
                        height: controller.screenHeight(context) * 0.03,
                      ),
                      const Text(
                        "Our Socials : ",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: controller.screenHeight(context) * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            child: const SizedBox(
                                width: 35,
                                height: 35,
                                child: Icon(
                                  color: Colors.white,
                                  FontAwesomeIcons.instagram,
                                  size: 36,
                                )),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            child: const Icon(
                              color: Colors.white,
                              FontAwesomeIcons.facebook,
                              size: 36,
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            child: const SizedBox(
                              width: 33,
                              height: 33,
                              child: Icon(
                                color: Colors.white,
                                FontAwesomeIcons.twitter,
                                size: 36,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: controller.screenHeight(context) * 0.02,
                      ),
                      /* ElevatedButton(
                        onPressed: () {
                          Get.to(const SignupPage());
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),*/
                      ElevatedButton(
                        onPressed: () async {
                          if (enteredNumber == userList[0]["number"] &&
                              enteredPass == userList[0]["pass"]) {
                            controller.Logintrue();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  controller.screenWidth(context) * 0.2),
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: controller.screenHeight(context) * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don`t Have an Account?",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Get.to(const SignupPage());
                            },
                            child: const Text(
                              "SignUp",
                              style: TextStyle(
                                  color: Color(0xFFEC6335),
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
