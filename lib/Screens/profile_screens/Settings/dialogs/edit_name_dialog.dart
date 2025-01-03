import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/main.dart';
import 'package:mamamia_uniproject/main_page.dart';

///! shows smaller map with two buttons after the user clicked the auto
class EditNameDialog extends StatelessWidget {
  const EditNameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenWidth = Get.find<Model>().screenWidth(context);

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
                "Edit UserName".tr,
                style: TextStyle(color: MainPage.orangeColor),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.secondary,
                    filled: true,
                    prefixIcon: const Icon(Icons.edit),
                    prefixIconColor: Colors.grey,
                    hintText: "New UserName".tr,
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
