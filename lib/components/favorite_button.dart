import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/Controllers/favoriteController.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';

class FavoriteButton extends StatelessWidget {
  final Product product;
  const FavoriteButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomePageProductController(),
        builder: (controller) => IconButton(
            onPressed: () {
              controller.productisFavored(product);
            },
            icon: product.isFavored
                ? Icon(
                    Icons.favorite,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : const Icon(Icons.favorite_outline)));
  }
}
