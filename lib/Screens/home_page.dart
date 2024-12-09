import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/components/ads.dart';
import 'package:mamamia_uniproject/components/home_app_bar.dart';
import 'package:mamamia_uniproject/components/categories_icons.dart';
import 'package:mamamia_uniproject/components/search_bar.dart';

class HomeNeedToBeSlivered extends StatelessWidget {
  const HomeNeedToBeSlivered({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Scaffold(
      //@ useful shit
      extendBody: true,
      //! appbar
      appBar: ProjectAppBar_homePage(),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            //! search Bar
            ProjectSearchBar(),
            //! Ads shit
            AdsIndicator(pageController),
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProjectCategoriesIcons(
                      icon: Icons.fastfood_outlined, categorie: 'Food'.tr),
                  ProjectCategoriesIcons(
                      icon: Icons.card_giftcard_sharp, categorie: 'Gifts'.tr),
                  ProjectCategoriesIcons(
                      icon: Icons.woman, categorie: 'Women'.tr),
                  ProjectCategoriesIcons(
                      icon: Icons.sports_kabaddi_sharp, categorie: 'Kids'.tr),
                  //! when clicked the most popular must change and the product info below
                  // i know its should not be static info but for now thats what i got :F
                  //! enums??
                ],
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
      ),
    );
  }
}
