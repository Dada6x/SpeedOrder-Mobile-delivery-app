import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamamia_uniproject/model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Model>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFFEC6335),
                  )),
              title: const Text(
                "Enter Your Info",
                style: TextStyle(fontSize: 25),
              ),
              elevation: 0,
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: MaterialButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const ImagePickingDialog();
                              });
                        },
                        shape: const CircleBorder(),
                        child: const Icon(
                          Icons.add_a_photo,
                          size: 40,
                        ),
                      ),
                    ),
                    const Text(
                      "Add Photo",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFFEC6335),
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: controller.screenHeight(context) * 0.03,
                    ),
                    SizedBox(
                      width: controller.screenHeight(context) * 0.2,
                      child: const TextField(
                          decoration: InputDecoration(
                              fillColor: Color(0xFF191919),
                              filled: true,
                              hintText: "Firstname",
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
                              ))),
                    ),
                    SizedBox(
                      width: controller.screenHeight(context) * 0.12,
                    ),
                    SizedBox(
                      width: controller.screenHeight(context) * 0.2,
                      child: const TextField(
                          decoration: InputDecoration(
                              fillColor: Color(0xFF191919),
                              filled: true,
                              hintText: "Lastname",
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
                              ))),
                    )
                  ],
                ),
                SizedBox(
                  height: controller.screenHeight(context) * 0.03,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: controller.screenWidth(context) * 0.05),
                    child: const TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            fillColor: Color(0xFF191919),
                            filled: true,
                            prefixIcon: Icon(Icons.call_outlined),
                            hintText: "Number",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF191919)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF191919)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )))),
                SizedBox(
                  height: controller.screenHeight(context) * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: controller.screenWidth(context) * 0.05),
                  child: const TextField(
                      decoration: InputDecoration(
                          fillColor: Color(0xFF191919),
                          filled: true,
                          prefixIcon: Icon(Icons.key),
                          hintText: "Password",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF191919)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF191919)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ))),
                ),
                SizedBox(
                  height: controller.screenHeight(context) * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: controller.screenWidth(context) * 0.05),
                  child: const TextField(
                      decoration: InputDecoration(
                          fillColor: Color(0xFF191919),
                          filled: true,
                          prefixIcon: Icon(Icons.location_pin),
                          hintText: "Location",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF191919)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF191919)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ))),
                ),
                SizedBox(
                  height: Get.find<Model>().screenHeight(context) * 0.05,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            Get.find<Model>().screenWidth(context) * 0.20),
                    child: const Text("Submit"),
                  ),
                )
              ],
            ));
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
                      title: const Text("GalleryImage"),
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
