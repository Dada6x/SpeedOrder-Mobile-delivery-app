import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/main.dart';
import 'package:mamamia_uniproject/main_page.dart';

///! shows smaller map with two buttons after the user clicked the auto
class EditPasswordDialog extends StatelessWidget {
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

  const EditPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final numberController = TextEditingController();
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    String? enteredNumber;
    return Center(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          width: screenWidth(context) * 0.8,
          height: screenHeight(context) * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Change Password".tr,
                style: TextStyle(color: MainPage.orangeColor),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
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
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).colorScheme.secondary,
                      filled: true,
                      prefixIcon: const Icon(Icons.phone),
                      prefixIconColor: Colors.grey,
                      hintText: "Phone Number".tr,
                      hintStyle: const TextStyle(color: Colors.grey),
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
                      ),
                    ),
                    controller: numberController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.secondary,
                    filled: true,
                    prefixIcon: const Icon(Icons.password),
                    prefixIconColor: Colors.grey,
                    hintText: "Old password".tr,
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: oldPasswordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.secondary,
                    filled: true,
                    prefixIcon: const Icon(Icons.password),
                    prefixIconColor: Colors.grey,
                    hintText: "New Password".tr,
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: newPasswordController,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Back'.tr)),
                  ProjectButton(
                    text: 'Save'.tr,
                    width: 100,
                    function: () {
                      if (oldPasswordController.text.isEmpty ||
                          numberController.text.isEmpty ||
                          newPasswordController.text.isEmpty) {
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
                        Get.find<Model>().editUserPasswordRequest(
                          numberController.text,
                          oldPasswordController.text,
                          newPasswordController.text,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
