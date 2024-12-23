import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/favoriteController.dart';

import 'package:mamamia_uniproject/components/normal_appbar.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NormalAppBar('Favorites'.tr),
        body: Obx(() {
          if (Get.find<FavoriteController>().favoriteItems.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Icon(
                    Icons.favorite,
                    size: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Center(
                  child: Text("fav Page".tr),
                ),
              ],
            ));
          }
          return Column(children: [
            Expanded(
              child: ListView.builder(
                itemCount: Get.find<FavoriteController>().favoriteItems.length,
                itemBuilder: (context, index) {
                  return Get.find<FavoriteController>()
                      .favoriteCardsList[index];
                },
              ),
            ),
          ]);
        })

        /* Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.favorite,
              size: 50,
              color: MainPage.orangeColor,
            ),
          ),
          const Center(
            child: Text('fav Page'),
          ),
        ],
      ),*/
        );
  }
}
