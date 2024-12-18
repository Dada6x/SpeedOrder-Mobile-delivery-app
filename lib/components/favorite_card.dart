import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/Controllers/favoriteController.dart';
import 'package:mamamia_uniproject/Screens/productpage.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';
import 'package:mamamia_uniproject/main_page.dart';

class FavoriteCard extends StatelessWidget {
  int? indexinList;
  FavoriteCard({
    super.key,
    required this.product,
  }); //default constructor
  FavoriteCard.inList(
      {super.key,
      required this.product,
      required this.indexinList}); //comstructor used for list
  Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductPage(product: product));
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // the color of the card
                color: Theme.of(context).colorScheme.secondary),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                          //! the product image @cart
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
                        Text(
                          //! product name @cart
                          product.name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                        ),
                        Text(product.description),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            //! product price @cart
                            '${product.price} \$',
                            style: TextStyle(
                                color: MainPage.orangeColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.find<FavoriteController>()
                                  .removeFromCart(product);
                              Get.find<HomePageProductController>()
                                  .productisFavored(product);
                            },
                            icon: Icon(
                              Icons.close,
                              color: MainPage.orangeColor,
                              size: 30,
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
