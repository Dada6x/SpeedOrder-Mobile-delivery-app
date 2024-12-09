import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/main_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar('Favorites'.tr),
      body: Column(
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
      ),
    );
  }
}
