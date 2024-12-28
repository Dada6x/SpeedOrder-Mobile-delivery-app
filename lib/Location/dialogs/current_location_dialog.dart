import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model.dart';
import 'package:mamamia_uniproject/Location/maps/CurrentLoaction/network_status_Current_location.dart';
import 'package:mamamia_uniproject/components/Button.dart';

///! shows smaller map with two buttons after the user clicked the auto
class CurrentLocationDialog extends StatelessWidget {
  const CurrentLocationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.find<Model>().screenWidth(context);
    // String location = Get.find<LocationController>().getCurrentLocation();
    return Center(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
            width: screenWidth * 0.8,
            height: screenWidth * 0.98,
            child: Column(
              children: [
                const Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: NetworkStatus2()),
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
                          child: Text('Back'.tr)),
                      ProjectButton(
                        text: 'Done'.tr,
                        width: 100,
                        function: () {
                          Get.back();
                          // Get.offAll(const MainPage());
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
