import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/orders_controller.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar("Order's History".tr),
      body: ListView.builder(
        itemCount: Get.find<OrdersController>().orderedCardsList.length,
        itemBuilder: (context, index) {
          return Get.find<OrdersController>().orderedCardsList[index];
        },
      ),
    );
  }
}