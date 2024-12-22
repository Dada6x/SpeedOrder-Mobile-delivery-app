import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';
import 'package:mamamia_uniproject/Auth/location/setLocation.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
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
          body: SingleChildScrollView(
            child: Column(
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
                        },
                        child: Get.find<Model>().imageIspicked
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
                              )),
                  ),
                ),
                SizedBox(
                  height: controller.screenHeight(context) * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: controller.screenWidth(context) * 0.05),
                  child: SizedBox(
                    child: TextField(
                        decoration: InputDecoration(
                            fillColor: Theme.of(context).colorScheme.secondary,
                            filled: true,
                            prefixIcon: const Icon(Icons.person_2_outlined),
                            prefixIconColor: Colors.grey,
                            hintText: "First Name".tr,
                            hintStyle: const TextStyle(color: Colors.grey),
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
                            prefixIconColor: Colors.grey,
                            prefixIcon: const Icon(Icons.account_box),
                            fillColor: Theme.of(context).colorScheme.secondary,
                            filled: true,
                            hintText: "Last Name".tr,
                            hintStyle: const TextStyle(color: Colors.grey),
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
                            fillColor: Theme.of(context).colorScheme.secondary,
                            filled: true,
                            prefixIcon: const Icon(Icons.call_outlined,
                                color: Colors.grey),
                            hintText: "Number".tr,
                            hintStyle: const TextStyle(color: Colors.grey),
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
                            )))),
                SizedBox(
                  height: controller.screenHeight(context) * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: controller.screenWidth(context) * 0.05),
                  child: TextField(
                      decoration: InputDecoration(
                          fillColor: Theme.of(context).colorScheme.secondary,
                          filled: true,
                          prefixIcon: const Icon(Icons.key, color: Colors.grey),
                          hintText: "Password".tr,
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ))),
                ),
                SizedBox(
                  height: controller.screenHeight(context) * 0.03,
                ),
                //! wards location

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
    _selectedImage = File(returnedImage.path);
    giveselectedImage(_selectedImage!);
  }

  Future pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;

    _selectedImage = File(returnedImage.path);
    giveselectedImage(_selectedImage!);
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
