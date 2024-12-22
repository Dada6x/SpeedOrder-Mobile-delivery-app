import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/location/Maps/locationController.dart';
import 'package:mamamia_uniproject/Auth/model.dart';
import 'package:mamamia_uniproject/Screens/profile_page.dart';
import 'package:mamamia_uniproject/components/ads.dart';
import 'package:mamamia_uniproject/components/categories_icons.dart';
import 'package:mamamia_uniproject/components/search_bar.dart';
import 'package:solar_icons/solar_icons.dart';

class HomeNeedToBeSlivered extends StatelessWidget {
  const HomeNeedToBeSlivered({super.key});
// dis is the screen that appear with the sliver appbar in the action section
  @override
  Widget build(BuildContext context) {
    String location = Get.find<LocationController>().getCurrentLocation();


    final pageController = PageController();
    return Scaffold(
      //@ useful shit
      extendBody: true,
      //! appbar
      appBar: PreferredSize(
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
                child: CircleAvatar(
                  radius: 10,
                  //! THE USER IMAGE
                  backgroundImage: Get.find<Model>().pickedImage,
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 8),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //! i want the location to be here
                    child: Center(child: Text(location)),
                  )),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          //! search Bars
          const ProjectSearchBar(),
          //! Ads shit
          AdsIndicator(
            controller: pageController,
          ),
          Align(
            alignment: Get.locale?.languageCode == 'ar'
                ? Alignment.centerRight // Align right for Arabic
                : Alignment.centerLeft, // Align left for English
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Categories'.tr,
                style: const TextStyle(fontSize: 22, color: Colors.grey),
              ),
            ),
          ),
          //! categories
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProjectCategoriesIcons(
                      icon: Icons.fastfood_outlined, categorie: 'Food'),
                  ProjectCategoriesIcons(
                      icon: SolarIconsOutline.tShirt, categorie: 'Clothes'.tr),
                  ProjectCategoriesIcons(
                      icon: Icons.monitor, categorie: 'Devices'),
                  ProjectCategoriesIcons(
                      icon: SolarIconsOutline.home1, categorie: 'Home'),
                  //! when clicked the most popular must change and the product info below
                  // i know its should not be static info but for now thats what i got :F
                  //! enums??
                ],
              ),
            ),
          ),
          Align(
            alignment: Get.locale?.languageCode == 'ar'
                ? Alignment.centerRight // Align right for Arabic
                : Alignment.centerLeft, // Align left for English
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Most popular'.tr,
                style: const TextStyle(fontSize: 21, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
