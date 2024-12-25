import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/main_page.dart';

///! shows smaller map with two buttons after the user clicked the auto
class EditPasswordDialog extends StatelessWidget {
  const EditPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.find<Model>().screenWidth(context);

    return Center(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          width: screenWidth * 0.8,
          height: screenWidth * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Edit Password".tr,
                style: TextStyle(color: MainPage.orangeColor),
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
                    function: () {},
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
