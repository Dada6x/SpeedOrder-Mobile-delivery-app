import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model.dart';
import 'package:mamamia_uniproject/Screens/profile_page.dart';
import 'package:mamamia_uniproject/main_page.dart';

PreferredSizeWidget ProjectAppBar_homePage() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: AppBar(
        scrolledUnderElevation: 0.0,
        surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: GestureDetector(
            onTap: () => Get.to(const ProfilePage()),
            child: const CircleAvatar(
              radius: 10,
              backgroundImage: AssetImage('assets/images/weekend.png'),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 8),
              onPressed: () {
                Get.dialog(barrierDismissible: false, const LocationDialog());
                /*Get.bottomSheet(
                    isDismissible: true,
                    BottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        onClosing: () {},
                        builder: (context) {
                          return SizedBox(
                            height: 120,
                            child: ListView(
                              children: [
                                ListTile(
                                  onTap: () {},
                                  title:
                                      Text("Change Location Automatically".tr),
                                ),
                                ListTile(
                                  onTap: () {},
                                  title: Text("Change Location Manualy".tr),
                                )
                              ],
                            ),
                          );
                        }));*/
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('\' Location \''.tr),
              )),
        ),
      ),
    ),
  );
}

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
                padding:
                    const EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 25),
                child: Text(
                  " Enter Location".tr,
                  style: TextStyle(
                      fontSize: 20,
                      color: MainPage.orangeColor,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_pin,
                        color: MainPage.orangeColor,
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
                            backgroundColor: MainPage.orangeColor),
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
