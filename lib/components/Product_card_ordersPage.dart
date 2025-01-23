import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:http/http.dart' as http;

import 'package:mamamia_uniproject/main.dart';

// ignore: must_be_immutable
class ProjectProductOrdersCard extends StatelessWidget {
  List products;
  var id;

  ProjectProductOrdersCard(
      {super.key, required this.id, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("order #$id"),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(SubmitDeleteOrder(
                id: id,
              ));
            },
            icon: const Icon(Icons.delete),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Text(
                      "#${products[index]["id"]}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    title: Text(products[index]["name"]),
                    subtitle: Text("${products[index]["price"]}\$"),
                    trailing: Text(
                      "x${products[index]["count"]}",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
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
  var id;
  Future<void> cancelOrder() async {
    String? token = await Get.find<Model>().getToken();

    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/auth/cancel_order"),
        body: {"token": token, "confirm_id": "$id"});
  }

  SubmitDeleteOrder({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          width: screenWidth(context) * 0.6,
          height: screenWidth(context) * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary),
                onPressed: () async {
                  await cancelOrder();
                  Get.back();
                  Get.back();
                },
                child: Text(
                  "Cancel Order".tr,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
