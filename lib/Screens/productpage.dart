import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:like_button/like_button.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/Controllers/cart_controller.dart';
import 'package:mamamia_uniproject/Controllers/favoriteController.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';
import 'package:mamamia_uniproject/components/favorite_button.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  const ProductPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        elevation: 0,
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
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FavoriteButton(product: product))
            ],
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ElevatedButton(
                  onPressed: () {}, child: Icon(Icons.arrow_downward))),
          ProjectButton(
            function: () {
              cartController.addToCart(product);
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
            width: double.infinity,
          )
        ],
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
                  productImage: product.imageLink,
                ),
                ProductInfoCardPage(
                  screenHeight: screenHeight,
                  product: product,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductInfoCardPage extends StatelessWidget {
  const ProductInfoCardPage(
      {super.key, required this.screenHeight, required this.product});

  final double screenHeight;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: screenHeight / 3 - 20, left: 20, right: 20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
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
            product.name,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          ProjectProductCartCardHome(product: product)
              .iconType(context, product.category)!,
          const SizedBox(
            height: 10,
          ),
          const Text(
            "f your assignment asks you to take a position or develop a claim about a subject, you may need to convey that position or claim in a thesis statement near the beginning of your draft. The assignment may not explicitly state that you need a thesis statement because your instructor may assume you will include one. When in doubt, ask your instructor if the assignment requires a thesis statement. When an assignment asks you to analyze, to interpret, to compare and contrast, to demonstrate cause and effect, or to take a stand on an issue, if your assignment asks you to take a position or develop a claim about a subject, you may need to convey that position or claim in a thesis statement near the beginning of your draft. The assignment may not explicitly state that you need a thesis statement because your instructor may assume you will include one. When in doubt, ask your instructor if the assignment requires a thesis statement. When an assignment asks you to analyze, to interpret, to compare and contrast, to demonstrate cause and effect, or to take a stand on an issue, ",
            overflow: TextOverflow.ellipsis,
            maxLines: 10,
          ),
          const Spacer(
            flex: 1,
          ),
          Text(
            '\$' + product.price.toString(),
            style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700),
          ),
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
