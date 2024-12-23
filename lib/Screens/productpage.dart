import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:mamamia_uniproject/Controllers/cart_controller.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';
import 'package:mamamia_uniproject/main_page.dart';

class ZProductPage extends StatelessWidget {
  final Product product;
  const ZProductPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      //! share extention here
                    },
                    icon: const Icon(Icons.share)),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: LikeButton(),
              )
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  height: 127,
                  width: screenWidth,
                  //! Background image icon
                  'assets/images/food2.png',
                  color: Colors.grey,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CircleAvatar(
                    radius: 120,
                    backgroundColor: MainPage.orangeColor,
                    //! product image @ZproductPage
                    backgroundImage: AssetImage(product.imageLink),
                  ),
                ),
              )
            ]),
          ),
          Expanded(
              //! the product info @ZproductPage
              child: Container(
            child: Column(
              children: [
                Center(
                  child: Text(
                    product.name,
                    style: const TextStyle(fontSize: 30),
                  ),),
                  const Divider(
                    indent: 10,
                    endIndent: 10,
                  ),
                  const Text('description and price goes here')
                  //! description and the rest of the shit and price and etc
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
            child: ProjectButton(
              function: () {
                //! adding it to the Cart via cart controller
                cartController.addToCart(product);
                //! added snackbar notify
                product.isInCart
                    ? Get.snackbar(
                        "Already in",
                        "${product.name} is already in Your cart!",
                        colorText: Theme.of(context).colorScheme.primary,
                      )
                    : Get.snackbar(
                        colorText: Theme.of(context).colorScheme.primary,
                        'Success'.tr,
                        '${product.name} added to the cart'.tr,
                        snackPosition: SnackPosition.TOP);
              },
              text: 'Add to Cart'.tr,
              width: screenWidth,
            ),
          )
        ],
      ),
    );
  }
}
