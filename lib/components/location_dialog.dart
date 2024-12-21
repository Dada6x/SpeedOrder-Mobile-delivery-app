import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model.dart';

class LocationDialog extends StatelessWidget {
  const LocationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = Get.find<Model>().screenWidth(context);
    double screenheight = Get.find<Model>().screenHeight(context);

    return Center(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          width: screenwidth * 0.8,
          height: screenheight * 0.22,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10, right: 10, bottom: 25),
                child: Text(
                  " Enter Location".tr,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_pin,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      hintText: "Location".tr,
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(170, 158, 158, 158)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("back".tr)),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            foregroundColor: Colors.white,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary),
                        onPressed: () {},
                        child: Text("Enter".tr)),
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
