import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:http/http.dart' as http;

import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';
import 'package:mamamia_uniproject/main.dart';


class ProjectProductOrdersCard extends StatelessWidget {
  // Order order;
  Product product = Product(1, "Coffee", 100, "Helps you break ankels",
      "assets/images/product.png", "Store", 1);
  ProjectProductOrdersCard({
    super.key,
  });


  Future<void> cancelOrder() async {
    String? token = await Get.find<Model>().getToken();
    final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/api/auth/get_total_price"),
        body: {"token": token});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
          onPressed: () {
            Get.dialog(SubmitDeleteOrder());
          },
          icon: const Icon(Icons.delete)),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name),
                        Text(product.price.toString() + "\$"),
                      ],
                    ),
                    trailing: Text(
                      product.count.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}

class SubmitDeleteOrder extends StatelessWidget {
  const SubmitDeleteOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          width: screenWidth(context) * 0.8,
          height: screenWidth(context) * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Confirm Delete".tr,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              TextButton(
                  onPressed: () async {
                    // Get.find<OrdersController>().deleteOrder(order);
                    Get.back();
                    Get.back();
                  },
                  child: const Text(
                    "Confirm",
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
