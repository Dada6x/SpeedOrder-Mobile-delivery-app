import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';

class HomePageProductController extends GetxController {
  Icon heart = const Icon(Icons.favorite_border_outlined);

  void productisFavored(Product p) {
    p.isFavored = !p.isFavored;
    update();
  }

  List productList = [];
}
