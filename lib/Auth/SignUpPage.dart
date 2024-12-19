import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';
import 'package:mamamia_uniproject/Auth/setLocation.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/main_page.dart';
import 'package:mamamia_uniproject/Auth/model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignupPage> {
  Image? img;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Model>(
      builder: (controller) {
        return Scaffold(
          appBar: NormalAppBar('Enter your info'.tr),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: controller.screenHeight(context) * 0.02,
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
                        img = Image(
                            fit: BoxFit.cover,
                            image: FileImage(Get.find<Model>().pickedImage!));
                      },
                      child: Get.find<Model>().imageIspicked && img != null
                          ? CircleAvatar(
                              backgroundImage: img!.image,
                            )
                          : const Icon(
                              Icons.add_a_photo,
                              size: 50,
                            ),
                    )
                    /*MaterialButton(
                    color: MainPage.greyColor,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const ImagePickingDialog();
                          });
                    },
                    shape: const CircleBorder(),
                    child: Get.find<Model>().imageIspicked
                        ? Get.find<Model>().pickedImage
                        : const Icon(
                            Icons.add_a_photo,
                            size: 50,
                          ),
                  ),*/
                    ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: controller.screenWidth(context) * 0.05),
                child: SizedBox(
                  child: TextField(
                      decoration: InputDecoration(
                          hintText: "First Name".tr,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MainPage.greyColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MainPage.greyColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ))),
                ),
              ),
              SizedBox(
                height: controller.screenHeight(context) * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: controller.screenWidth(context) * 0.05),
                child: SizedBox(
                  child: TextField(
                      decoration: InputDecoration(
                          hintText: "Last Name".tr,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MainPage.greyColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MainPage.greyColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ))),
                ),
              ),
              SizedBox(
                height: controller.screenHeight(context) * 0.03,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: controller.screenWidth(context) * 0.05),
                  child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.call_outlined),
                          hintText: "Number".tr,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MainPage.greyColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MainPage.greyColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          )))),
              SizedBox(
                height: controller.screenHeight(context) * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: controller.screenWidth(context) * 0.05),
                child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.key),
                        hintText: "Password".tr,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MainPage.greyColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MainPage.greyColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ))),
              ),
              SizedBox(
                height: controller.screenHeight(context) * 0.03,
              ),
//! wards location
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: controller.screenWidth(context) * 0.05),
              //   child: TextField(
              //       decoration: InputDecoration(
              //
              //           prefixIcon: const Icon(Icons.location_pin),
              //           hintText: "Location",
              //           enabledBorder: OutlineInputBorder(
              //             borderSide: BorderSide(color: MainPage.greyColor),
              //             borderRadius:
              //                 const BorderRadius.all(Radius.circular(10)),
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //             borderSide: BorderSide(color: MainPage.greyColor),
              //             borderRadius:
              //                 const BorderRadius.all(Radius.circular(10)),
              //           ))),
              // ),
              SizedBox(
                height: Get.find<Model>().screenHeight(context) * 0.03,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: ProjectButton(
                  text: 'Next'.tr,
                  width: controller.screenWidth(context),
                  function: () {
                    Get.off(const SettingLocation());
                  },
                ),
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
                      Get.off(const LoginPage());
                    },
                    child: Text(
                      "Sign in".tr,
                      style: TextStyle(
                          color: MainPage.orangeColor,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ImagePickingDialog extends StatefulWidget {
  const ImagePickingDialog({super.key});

  @override
  State<ImagePickingDialog> createState() => _ImagePickingDialogState();
}

class _ImagePickingDialogState extends State<ImagePickingDialog> {
  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;

    setState(() {
      _selectedImage = File(returnedImage.path);
      giveselectedImage(_selectedImage!);
    });
  }

  Future pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
      giveselectedImage(_selectedImage!);
    });
  }

  void giveselectedImage(File img) {
    Get.find<Model>().changeImage(img);
  }

  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Model(),
        builder: (controller) => Dialog(
              child: SizedBox(
                width: controller.screenWidth(context) * 0.5,
                height: controller.screenHeight(context) * 0.25,
                child: SimpleDialog(
                  contentPadding: const EdgeInsets.all(0),
                  children: [
                    ListTile(
                      title: const Text("Gallery Image"),
                      onTap: pickImageFromGallery,
                    ),
                    ListTile(
                      title: const Text("Camera Image"),
                      onTap: pickImageFromCamera,
                    ),
                  ],
                ),
              ),
            ));
  }
}
