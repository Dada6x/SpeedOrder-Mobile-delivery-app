import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';

class HomePageProductController extends GetxController {
  Icon heart = const Icon(Icons.favorite_border_outlined);

  void productisFavored(Product p) {
    p.isFavored = !p.isFavored;
    update();
  }

  Product p1 = Product(
      'the weekend  ',
      57.53,
      'the arabic weekend limited edition',
      'assets/images/weekend.png',
      "food");
  Product p2 = Product(' قلابية ', 57.53, 'بيضة ملبوسة مستعملة',
      'assets/images/weekend.png', "clothes");
  Product p3 = Product(' Gucci ', 57.53, 'بيضة ملبوسة مستعملة',
      'assets/images/weekend.png', "clothes");
  Product p4 = Product(' louis ', 57.53, 'بيضة ملبوسة مستعملة',
      'assets/images/weekend.png', "clothes");
  List<Product> productList() {
    return [p1, p2, p3, p4];
  }
}
