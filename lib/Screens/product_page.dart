import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:like_button/like_button.dart';
import 'package:mamamia_uniproject/cart_controller.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/main_page.dart';

class ZProductPage extends StatelessWidget {
  final String productImage;
  final String productName;
  final double price;

  const ZProductPage(
      {super.key,
      required this.productName,
      required this.productImage,
      required this.price});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                const ProductBackgroundImage(),
                ProductImage(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  productImage: productImage,
                ),
                ProductInfoCardPage(
                    screenHeight: screenHeight,
                    price: price,
                    productName: productName),
                Positioned(
                  bottom: 0,
                  width: screenWidth,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 15),
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
                          width: double.infinity,
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
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
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductInfoCardPage extends StatelessWidget {
  const ProductInfoCardPage({
    super.key,
    required this.screenHeight,
    required this.price,
    required this.productName,
  });

  final double screenHeight;
  final double price;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: screenHeight / 3 - 30, left: 30, right: 30),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      height: screenHeight / 2,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\$' + price.toString(),
            // style: const TextStyle(),
          ),
          Text(
            productName,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "f your assignment asks you to take a position or develop a claim about a subject, you may need to convey that position or claim in a thesis statement near the beginning of your draft. The assignment may not explicitly state that you need a thesis statement because your instructor may assume you will include one. When in doubt, ask your instructor if the assignment requires a thesis statement. When an assignment asks you to analyze, to interpret, to compare and contrast, to demonstrate cause and effect, or to take a stand on an issue, if your assignment asks you to take a position or develop a claim about a subject, you may need to convey that position or claim in a thesis statement near the beginning of your draft. The assignment may not explicitly state that you need a thesis statement because your instructor may assume you will include one. When in doubt, ask your instructor if the assignment requires a thesis statement. When an assignment asks you to analyze, to interpret, to compare and contrast, to demonstrate cause and effect, or to take a stand on an issue, ",
            style: const TextStyle(color: Colors.black87),
            overflow: TextOverflow.ellipsis,
            maxLines: 15,
          )
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.productImage,
  });
  final String productImage;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      height: screenHeight / 3,
      width: screenWidth,
      //! Background image icon
      productImage,
      fit: BoxFit.cover,
    );
  }
}

class ProductBackgroundImage extends StatelessWidget {
  const ProductBackgroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/food2.png',
        color: Colors.black12,
        repeat: ImageRepeat.repeat,
        height: double.infinity,
      ),
    );
  }
}
