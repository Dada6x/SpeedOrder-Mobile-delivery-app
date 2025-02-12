import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/Screens/productpage.dart';
import 'package:mamamia_uniproject/components/Product_card_CartPage.dart';
import 'package:mamamia_uniproject/components/Product_card_ordersPage.dart';
import 'package:mamamia_uniproject/components/favorite_button.dart';
import 'package:mamamia_uniproject/components/favorite_card.dart';
import 'package:solar_icons/solar_icons.dart';

class Product {
  //added a class of products,might add a product id if the backend wants it
  var id;
  var CartId;
  String? imageLink;
  String? name;
  var price;
  String? description;
  String? category;
  String? company;
  var count;
  String? purchaseDate;
  bool isFavored = false;
  bool isInCart = false;
  ProjectProductCartCard? cartCard;
  FavoriteCard? favoriteCard;
  ProjectProductOrdersCard? orderCard;
  Product(
    this.id,
    this.name,
    this.price,
    this.imageLink, [
    this.description,
    this.company,
    this.count,
  ]);
  Product.cart();
}

/// this is the product card in the [HomePage] it has price and fav button
Image imgprv(String url) {
  try {
    print(url);
    return Image(
      image: NetworkImage(url),
      fit: BoxFit.contain,
    );
  } catch (e) {
    return const Image(
      image: AssetImage("assets/images/product.png"),
      fit: BoxFit.contain,
    );
  }
}

// ignore: must_be_immutable
class ProjectProductCartCardHome extends StatelessWidget {
  var id;
  
  String name;
  var price;
  bool isFavorite;
  String category;
  ProjectProductCartCardHome({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.isFavorite,
  });
  Icon? iconType(BuildContext context, String type) {
    if (type == "food") {
      return Icon(
        Icons.fastfood_outlined,
        color: Theme.of(context).colorScheme.primary,
      );
    }
    if (type.contains("jew")) {
      return Icon(
        Icons.diamond_outlined,
        color: Theme.of(context).colorScheme.primary,
      );
    }
    if (type.contains("cloth")) {
      return Icon(
        SolarIconsOutline.tShirt,
        color: Theme.of(context).colorScheme.primary,
      );
    }
    if (type == "devices") {
      return Icon(
        Icons.monitor,
        color: Theme.of(context).colorScheme.primary,
      );
    }
    if (type == "home") {
      return Icon(
        SolarIconsOutline.home1,
        color: Theme.of(context).colorScheme.primary,
      );
    }
    return null;
  }

  File getimgFile(String path) {
    String fullpath = "project17/storage/app/private/$path";
    File f = File(fullpath);
    return f;
  }

  Icon heart = const Icon(Icons.favorite_border);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomePageProductController(),
        builder: (controller) => Directionality(
              textDirection: TextDirection.ltr,
              child: GestureDetector(
                onTap: () {
                  Get.to(ProductPage(id: id));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 100,
                              //! the product image
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: const Image(
                                    image: AssetImage(
                                        "assets/images/product.png"),
                                    fit: BoxFit.contain,
                                  )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //! the product name
                                Text(
                                  name,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                //  Text(description),
                                Row(
                                  children: [
                                    //! the product category
                                    iconType(context, category)!,
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                                //! the product like button
                                padding: const EdgeInsets.all(8.0),
                                child: FavoriteButton(
                                  id: id,
                                  isFavorite: isFavorite,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              //! the product price
                              child: Text(
                                '$price\$',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
