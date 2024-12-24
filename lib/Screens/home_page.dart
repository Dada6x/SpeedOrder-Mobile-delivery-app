import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/locationController_map.dart';
import 'package:mamamia_uniproject/Auth/model.dart';
import 'package:mamamia_uniproject/Screens/profile_page.dart';
import 'package:mamamia_uniproject/components/ads.dart';
import 'package:mamamia_uniproject/components/categories_icons.dart';
import 'package:mamamia_uniproject/Location/Maps/location_dialog.dart';
import 'package:mamamia_uniproject/components/search_bar.dart';
import 'package:mamamia_uniproject/main_page.dart';
import 'package:solar_icons/solar_icons.dart';

class HomeNeedToBeSlivered extends StatelessWidget {
  const HomeNeedToBeSlivered({super.key});
// dis is the screen that appear with the sliver appbar in the action section
  @override
  Widget build(BuildContext context) {
    String location = Get.find<LocationController>().getCurrentLocation();

    final pageController = PageController();
    return Scaffold(
      extendBody: true,
      //! appbar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      MainPage.scaffoldKey.currentState?.openEndDrawer();
                    },
                    icon: Icon(
                      Icons.notifications,
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
                    )),
              )
            ],
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
            //! location in the homepage
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 2),
                  onPressed: () {
                    Get.dialog(const LocationDialog());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
              child: SingleChildScrollView(
                scrollDirection:
                    Axis.horizontal, // Make it horizontally scrollable
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // Ensure the Row starts from the left
                    children: [
                      //TODO WARD ADD MORE CATEGORIES 💋
                      ProjectCategoriesIcons(
                          icon: Icons.fastfood_outlined, categorie: 'Food'),
                      ProjectCategoriesIcons(
                          icon: SolarIconsOutline.tShirt,
                          categorie: 'Clothes'.tr),
                      ProjectCategoriesIcons(
                          icon: Icons.monitor, categorie: 'Devices'),
                      ProjectCategoriesIcons(
                          icon: SolarIconsOutline.home1, categorie: 'Home'),
                      ProjectCategoriesIcons(
                          icon: SolarIconsOutline.home1, categorie: 'Home'),
                      ProjectCategoriesIcons(
                          icon: SolarIconsOutline.home1, categorie: 'Home'),
                      ProjectCategoriesIcons(
                          icon: SolarIconsOutline.home1, categorie: 'Home'),
                      ProjectCategoriesIcons(
                          icon: SolarIconsOutline.home1, categorie: 'Home'),
                      // Add more categories if needed
                    ],
                  ),
                ),
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
