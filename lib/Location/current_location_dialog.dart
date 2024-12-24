import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model.dart';
import 'package:mamamia_uniproject/Location/Maps/current_location_map.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/main_page.dart';

///! shows smaller map with two buttons after the user clicked the auto
class CurrentLocationDialog extends StatelessWidget {
  const CurrentLocationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = Get.find<Model>().screenWidth(context);

    return Center(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
            width: screenwidth * 0.8,
            height: screenwidth * 0.98,
            child: Column(
              children: [
                const Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Currentlocationmap()),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child:  Text('Back'.tr)),
                      ProjectButton(
                        text: 'Done'.tr,
                        width: 100,
                        function: () {
                          Get.offAll(const MainPage());
                        },
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
