import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mamamia_uniproject/Controllers/cart_controller.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/payment_page.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: NormalAppBar('Your Cart'.tr),
      body: Obx(() {
        if (Get.find<CartController>().cartItems.isNotEmpty) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: Get.find<CartController>().cartItems.length,
                  itemBuilder: (context, index) {
                    return Get.find<CartController>().cartCardsList[index];
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
                    Text(
                      'Total:'.tr,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      '\$${Get.find<CartController>().totalPrice.toStringAsFixed(2)}',
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
                    Get.to(PaymentPage());
                  },
                ),
              )
            ],
          );
        }
        return Center(
            child: Column(
          children: [
            Lottie.asset('assets/animations/ghost.json'),
            Text('Your cart is empty !'.tr),
          ],
        ));
      }),
    );
  }
}
