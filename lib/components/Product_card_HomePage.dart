import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/Controllers/favoriteController.dart';
import 'package:mamamia_uniproject/Screens/product_page.dart';
import 'package:mamamia_uniproject/Screens/productpage.dart';
import 'package:mamamia_uniproject/components/Product_card_CartPage.dart';
import 'package:mamamia_uniproject/components/favorite_card.dart';
import 'package:solar_icons/solar_icons.dart';

class Product {
  //added a class of products,might add a product id if the backend wants it
  String imageLink;
  String name;
  double price;
  String description;
  String category;
  bool isFavored = false;
  bool isInCart = false;
  ProjectProductCartCard? cartCard;
  ProjectProductCartCardHome? homeCard;
  FavoriteCard? favoriteCard;
  Product(
      this.name, this.price, this.description, this.imageLink, this.category) {
    homeCard = ProjectProductCartCardHome(
      product: this,
    );
  }
}

/// this is the product card in the [HomePage] it has price and fav button

// ignore: must_be_immutable
class ProjectProductCartCardHome extends StatelessWidget {
  Product product;
  ProjectProductCartCardHome({super.key, required this.product});
  Icon? iconType(BuildContext context, String type) {
    if (type == "food") {
      return Icon(
        Icons.fastfood_outlined,
        color: Theme.of(context).colorScheme.primary,
      );
    }
    if (type == "clothes") {
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

  Icon heart = const Icon(Icons.favorite_border);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomePageProductController(),
        builder: (controller) => Directionality(
              textDirection: TextDirection.ltr,
              child: GestureDetector(
                onTap: () {
                  Get.to(ProductPage(product: product));
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
                                child: Image(
                                  image: AssetImage(product.imageLink),
                                  fit: BoxFit.cover,
                                ),
                              ),
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
                                  product.name,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(product.description),
                                Row(
                                  children: [
                                    //! the product category
                                    iconType(context, product.category)!,
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
                                child: IconButton(
                                    onPressed: () {
                                      controller.productisFavored(product);
                                      product.isFavored
                                          ? Get.find<FavoriteController>()
                                              .addToFavorite(product)
                                          : Get.find<FavoriteController>()
                                              .removeFromCart(product);
                                    },
                                    icon: product.isFavored
                                        ? Icon(
                                            Icons.favorite,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          )
                                        : const Icon(Icons.favorite_outline))),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              //! the product price
                              child: Text(
                                '${product.price}\$',
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
