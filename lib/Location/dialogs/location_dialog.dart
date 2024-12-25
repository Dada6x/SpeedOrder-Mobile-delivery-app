import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model.dart';
import 'package:mamamia_uniproject/Location/maps/manuallLocation/network_status_for_ManuallLocation.dart';
import 'package:mamamia_uniproject/Location/dialogs/current_location_dialog.dart';

class LocationDialog extends StatelessWidget {
  const LocationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.find<Model>().screenWidth(context);
    double screenHeight = Get.find<Model>().screenHeight(context);

    return Center(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          width: screenWidth * 0.8,
          height: screenHeight * 0.22,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10, right: 10, bottom: 25),
                child: Center(
                  child: Text(
                    " Edit Location".tr,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: TextField(
              //     decoration: InputDecoration(
              //         prefixIcon: Icon(
              //           Icons.location_pin,
              //           color: Theme.of(context).colorScheme.primary,
              //         ),
              //         hintText: "Location".tr,
              //         hintStyle: const TextStyle(
              //             color: Color.fromARGB(170, 158, 158, 158)),
              //         enabledBorder: OutlineInputBorder(
              //             borderSide: const BorderSide(color: Colors.grey),
              //             borderRadius: BorderRadius.circular(20)),
              //         focusedBorder: OutlineInputBorder(
              //             borderSide: const BorderSide(color: Colors.grey),
              //             borderRadius: BorderRadius.circular(20))),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.off(const NetworkStatus());
                        },
                        child:  Column(
                          children: [
                            const Icon(Icons.edit_location_alt_outlined,size: 32,),
                            Text("Manually".tr),
                          ],
                        )), //go to the full map
                    TextButton(
                        onPressed: () {
                          Get.dialog(const CurrentLocationDialog());
                        },
                        child:  Column(
                          children: [
                            const Icon(Icons.auto_fix_high_sharp,size: 32,),
                            Text("Auto".tr),
                          ],
                        )) // go to smaller one
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
