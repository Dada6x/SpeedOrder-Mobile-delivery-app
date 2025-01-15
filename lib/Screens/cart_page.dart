import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/Controllers/cart_controller.dart';
import 'package:mamamia_uniproject/Screens/payment_page.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/components/Product_card_CartPage.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatelessWidget {
  CartPage({super.key});
  double totalPrice = 0.0;
  Future<List> getCartProducts() async {
    String? token = await Get.find<Model>().getToken();
    final response = await http.post(
        Uri.parse("http://192.168.1.110:8000/api/auth/get_products_in_cart"),
        body: {
          "token": token,
        });
    getTotalPrice();
    List cartProducts = jsonDecode(response.body);
    print(cartProducts);
    return cartProducts;
  }

  Future<void> getTotalPrice() async {
    String? token = await Get.find<Model>().getToken();
    final response = await http.post(
        Uri.parse("http://192.168.1.110:8000/api/auth/get_total_price"),
        body: {"token": token});
    totalPrice = jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Get.find<CartController>().removeAllFromCart();
    // Get.find<CartController>().addToCart(Product(1, "Coffee", 100,
    //     "Helps you break ankels", "assets/images/product.png", "Store", 1));
    return Scaffold(
        appBar: NormalAppBar('Your Cart'.tr),
        body: FutureBuilder(
            future: getCartProducts(),
            builder: (context, snapshot) {
              var data = snapshot.data;
              if (data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var datalength = data.length;
                if (datalength == 0) {
                  return Center(
                      child: Column(
                    children: [
                      Lottie.asset('assets/animations/ghost.json'),
                      Text('Your cart is empty !'.tr),
                    ],
                  ));
                } else {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: datalength,
                          itemBuilder: (context, index) {
                            Product p = Product.cart();
                            p.CartId = data[index]["id"];
                            p.id = data[index]["product_details"]["id"];
                            p.name = data[index]["product_details"]["name"];
                            p.price = data[index]["product_details"]["price"];
                            p.count = data[index]["count"];
                            p.imageLink = "assets/images/product.png";
                            return ProjectProductCartCard(product: p);
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
                              "$totalPrice \$",
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
              }
            }));
  }
}


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