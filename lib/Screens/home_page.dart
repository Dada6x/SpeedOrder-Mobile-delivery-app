import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/components/ads.dart';
import 'package:mamamia_uniproject/components/home_app_bar.dart';
import 'package:mamamia_uniproject/components/categories_icons.dart';
import 'package:mamamia_uniproject/components/search_bar.dart';
import 'package:solar_icons/solar_icons.dart';

class HomeNeedToBeSlivered extends StatelessWidget {
  const HomeNeedToBeSlivered({super.key});
// dis is the screen that appear with the sliver appbar in the action section
  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Scaffold(
      //@ useful shit
      extendBody: true,
      //! appbar
      appBar: ProjectAppBar_homePage(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          //! search Bar
          const ProjectSearchBar(),
          //! Ads shit
          AdsIndicator(controller: pageController,),
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
