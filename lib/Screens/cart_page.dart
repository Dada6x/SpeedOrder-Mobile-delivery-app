import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mamamia_uniproject/cart_controller.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/components/Product_card_CartPage.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: NormalAppBar('Your Cart'.tr),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(
              child: Column(
            children: [
              Lottie.asset('assets/animations/ghost.json'),
              Text('Your cart is empty !'.tr),
            ],
          ));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.cartItems[index];
                  return ProjectProductCartCard(
                    imageAsset: item.imageAsset,
                    productName: item.productName,
                    description: item.description,
                    price: item.price,
                    mostlyDeleteButton: () {
                      cartController.removeFromCart(item);
                    },
                  );
                },
              ),
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '\$${cartController.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            const Divider(
              endIndent: 15,
              indent: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProjectButton(
                text: 'Check Out'.tr,
                width: screenWidth,
                function: () {
                  //! do the purchase
                },
              ),
            )
          ],
        );
      }),
    );
  }
}
