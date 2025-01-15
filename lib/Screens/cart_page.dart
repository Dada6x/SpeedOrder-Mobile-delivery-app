import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/Controllers/cart_controller.dart';
import 'package:mamamia_uniproject/Screens/payment_page.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  get http => null;
  Future<List> getCartProducts() async {
    String? token = await Get.find<Model>().getToken();
    final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/api/auth/get_products_in_cart"),
        body: {"token": token});
    List cartProducts = jsonDecode(response.body);
    Get.find<CartController>().addAllToCart(cartProducts);
    return cartProducts;
  }

  Future<int> getTotalPrice() async {
    String? token = await Get.find<Model>().getToken();
    final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/api/auth/get_total_price"),
        body: {"token": token});
    var price = jsonDecode(response.body);
    return price;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Get.find<CartController>().removeAllFromCart();
    // Get.find<CartController>().addToCart(Product(1, "Coffee", 100,
    //     "Helps you break ankels", "assets/images/product.png", "Store", 1));
    return Scaffold(
        appBar: NormalAppBar('Your Cart'.tr),
        body:
            // FutureBuilder(
            //     future: getCartProducts(),
            //     builder: (context, snapshot) {
            //       var data = snapshot.data;
            //       if (data == null) {
            //         return const Center(child: CircularProgressIndicator());
            //       } else {
            //         var datalength = data.length;
            //         if (datalength == 0) {
            //           return Center(
            //               child: Column(
            //             children: [
            //               Lottie.asset('assets/animations/ghost.json'),
            //               Text('Your cart is empty !'.tr),
            //             ],
            //           ));
            //         } else {
            //           return
            Column(
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
                    // '\$${Get.find<CartController>().totalPrice.toStringAsFixed(2)}',
                    getTotalPrice().toString(),
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
        ));
  }
}
//             }));
//   }
// }


        // child: Obx(() {
        //   if (Get.find<CartController>().cartItems.isNotEmpty) {
        //     return 
        //   }
        //   return Center(
        //       child: Column(
        //     children: [
        //       Lottie.asset('assets/animations/ghost.json'),
        //       Text('Your cart is empty !'.tr),
        //     ],
        //   )
        //   );
        // }),