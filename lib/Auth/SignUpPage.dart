import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';

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
  File? img;

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
                  //! Image
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: GestureDetector(
                      onTap: () => showImagePickerDialog(context),
                      child: CircleAvatar(
                        radius: 75,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        backgroundImage: img != null
                            ? FileImage(img!)
                            : null, // Use FileImage
                        child: img == null
                            ? const Icon(Icons.add_a_photo,
                                size: 40, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
                  //! First Name
                  buildTextField(
                    controller: firstNameController,
                    hint: "First Name",
                    icon: const Icon(Icons.person, color: Colors.grey),
                  ),
                  //! Last Name
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: buildTextField(
                      controller: lastNameController,
                      hint: "Last Name",
                      icon:
                          const Icon(Icons.person_outline, color: Colors.grey),
                    ),
                  ),
                  //! Phone Number
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        validator: validatePhoneNumber,
                        onChanged: (_) => formKey.currentState?.validate(),
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: numberController,
                        decoration: inputDecoration(
                          isPassword: false,
                          context: context,
                          hint: "Enter Number",
                          icon: const Icon(Icons.phone, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  //! Password
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: buildTextField(
                      controller: passwordController,
                      hint: " Enter Password",
                      icon: const Icon(Icons.key, color: Colors.grey),
                      isPassword: true,
                    ),
                  ),
                  //! Register Button
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: ProjectButton(
                      text: 'Next'.tr,
                      width: MediaQuery.of(context).size.width,
                      function: () {
                        if (formKey.currentState?.validate() ?? false) {
                          controller.signUpRequest(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            password: passwordController.text,
                            number: numberController.text,
                            image: img,
                          );
                        } else {
                          Get.snackbar(
                            "Error",
                            "Please fill all fields correctly",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                    ),
                  ),
                  //! Already have an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?".tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.off(() => const LoginPage()),
                        child: Text(
                          "Log in".tr,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
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

  //! Helper Widgets
  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    required Icon icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      decoration: inputDecoration(
        isPassword: isPassword,
        context: context,
        hint: hint,
        icon: icon,
      ),
    );
  }

  //! Input Decoration
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
                  : const Icon(Icons.visibility),
            )
          : null,
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

  //! Image Picker Dialog
  void showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            "Select Image",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                iconColor: Theme.of(context).colorScheme.primary,
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                iconColor: Theme.of(context).colorScheme.primary,
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a Photo"),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //! Pick Image Function
  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile == null) return;
      setState(() {
        img = File(pickedFile.path);
        Get.find<Model>().changeImage(img!);
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to pick image: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  //! Validator for Phone Number
  String? validatePhoneNumber(String? val) {
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
}
