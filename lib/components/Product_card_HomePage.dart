import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:mamamia_uniproject/Screens/productpage.dart';
import 'package:mamamia_uniproject/main_page.dart';

/// this is the product card in the [HomePage] it has price and fav button
class ProjectProductCartCardHome extends StatelessWidget {
  final String imageAsset;
  final String productName;
  final String description;
  final double price;
  final IconData categoryIcon;

  const ProjectProductCartCardHome({
    super.key,
    required this.imageAsset,
    required this.productName,
    required this.description,
    required this.price,
    required this.categoryIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //! when the product card is pressed in the homepage

        Get.to(ProductPage(
          productName: productName,
          productImage: imageAsset, price: price,
        ));
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
                        image: AssetImage(imageAsset),
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
                        productName,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(description),
                      Row(
                        children: [
                          //! the product category
                          Icon(
                            categoryIcon,
                            color: MainPage.orangeColor,
                            size: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  const Padding(
                      //! the product like button
                      padding: EdgeInsets.all(8.0),
                      child: LikeButton()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    //! the product price
                    child: Text(
                      '$price\$',
                      style: TextStyle(
                          color: MainPage.orangeColor,
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
    );
  }
}
