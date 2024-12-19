import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/SignUpPage.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/components/categories_icons.dart';
import 'package:mamamia_uniproject/components/language_toggle_button_icon.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/main_page.dart';
import 'package:mamamia_uniproject/Auth/model.dart';
import 'package:http/http.dart' as http;
import 'package:mamamia_uniproject/theme/theme_controller.dart';

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
              // appBar: NormalAppBar("Welcome !".tr),
              appBar: AppBar(
                title: Text(
                  "Welcome !".tr,
                  style: const TextStyle(fontSize: 30),
                ),
                actions: const [
                  ThemeToggleButtonIcon(),
                  LanguageToggleButtonIcon(),
                ],
              ),
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
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w800,
                              fontSize:
                                  controller.screenWidth(context) * 0.155),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Where Quality and Efficiency Meet.".tr,
                          style: const TextStyle(fontWeight: FontWeight.w600),
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
                                fillColor:
                                    Theme.of(context).colorScheme.secondary,
                                filled: true,
                                prefixIcon: const Icon(Icons.call_outlined,
                                    color: Colors.grey),
                                labelText: "Enter Number".tr,
                                labelStyle: const TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
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
                            fillColor: Theme.of(context).colorScheme.secondary,
                            filled: true,
                            prefixIcon:
                                const Icon(Icons.key, color: Colors.grey),
                            labelText: "Enter Password".tr,
                            labelStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            )),
                      )),
                      // SizedBox(
                      //   height: controller.screenHeight(context) * 0.03,
                      // ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Divider(),
                              ),
                            ),
                            Text('Our Socials'.tr),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Divider(),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProjectCategoriesIconsWithoutLabel(
                            icon: FontAwesomeIcons.facebook,
                            name: "facebook",
                          ),
                          ProjectCategoriesIconsWithoutLabel(
                            icon: FontAwesomeIcons.instagram,
                            name: "instagram",
                          ),
                          ProjectCategoriesIconsWithoutLabel(
                            icon: FontAwesomeIcons.twitter,
                            name: "twitter",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: controller.screenHeight(context) * 0.02,
                      ),

                      ProjectButton(
                        text: "Sign in".tr,
                        width: controller.screenWidth(context),
                        function: () async {
                          /* Get.dialog(const SimpleDialog(
                            children: [
                              Center(
                                  child: Text(
                                "Checking Info ....",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
                              Padding(
                                padding: const EdgeInsets.all(50.0),
                                child: LinearProgressIndicator(),
                              )
                            ],
                          ));*/
                          //Get.off(const MainPage());
                          final request =
                              await http.post(Uri.parse(""), body: {});
                          var requestbody = request.body;
                          // ignore: avoid_print
                          print("requestBody");
                          if (requestbody != "") {}
                          if (requestbody == "") {
                            Get.off(const MainPage());
                          }
                          print("wardadnanekhtar");
                        },
                      ),

                      SizedBox(
                        height: controller.screenHeight(context) * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don`t Have an Account?".tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.off(const SignupPage());
                            },
                            child: Text(
                              "Sign Up".tr,
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
            ));
  }
}
