import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/Screens/productpage.dart';
import 'package:mamamia_uniproject/components/Product_card_CartPage.dart';
import 'package:mamamia_uniproject/components/Product_card_ordersPage.dart';
import 'package:mamamia_uniproject/components/favorite_card.dart';
import 'package:solar_icons/solar_icons.dart';

class Product {
  //added a class of products,might add a product id if the backend wants it
  var id;
  String imageLink;
  String name;
  var price;
  String description;
  String? category;
  String company;
  var count;
  String? purchaseDate;
  bool isFavored = false;
  bool isInCart = false;
  ProjectProductCartCard? cartCard;
  FavoriteCard? favoriteCard;
  ProjectProductOrdersCard? orderCard;
  Product(this.id, this.name, this.price, this.description, this.imageLink,
      this.company, this.count);
}

/// this is the product card in the [HomePage] it has price and fav button

// ignore: must_be_immutable
class ProjectProductCartCardHome extends StatelessWidget {
  var id;
  String imageLink;
  String name;
  var price;
  String category;
  ProjectProductCartCardHome({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.imageLink,
    required this.category,
  });
  Icon? iconType(BuildContext context, String type) {
    if (type == "food") {
      return Icon(
        Icons.fastfood_outlined,
        color: Theme.of(context).colorScheme.primary,
      );
    }
    //? ??we got jews category before جاتا
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
                                child: Image(
                                  image: AssetImage(
                                    imageLink,
                                  ),
                                  fit: BoxFit.contain,
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
                            /* Padding(
                                //! the product like button
                                padding: const EdgeInsets.all(8.0),
                                child: FavoriteButton(product: product)),*/
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
