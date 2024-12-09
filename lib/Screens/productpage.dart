import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:mamamia_uniproject/cart_controller.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/main_page.dart';

class ProductPage extends StatelessWidget {
  final String productImage;
  final String productName;
  final double price;

  const ProductPage(
      {super.key,
      required this.productName,
      required this.productImage,
      required this.price});

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
                    //! product image @productPage
                    backgroundImage: AssetImage(productImage),
                  ),
                ),
              )
            ]),
          ),
          Expanded(
              //! the product info @productPage
              child: Container(
            child: Column(
              children: [
                Center(
                  child: Text(
                    productName,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                const Text('description and price goes here')
                //! description and the rest of the shit and price and etc
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
            child: ProjectButton(
              function: () {
                //! adding it to the Cart via cart controller
                cartController.addToCart(CartItem(
                  productName: productName,
                  description: '',
                  price: price,
                  imageAsset: productImage,
                ));
                //! added snackbar notify
                Get.snackbar(
                    colorText: MainPage.orangeColor,
                    'Success'.tr,
                    '$productName added to the cart'.tr,
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
