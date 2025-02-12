import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Models/order.dart';
import 'package:mamamia_uniproject/components/Product_card_ordersPage.dart';
import 'package:mamamia_uniproject/main_page.dart';

class OrderCard extends StatelessWidget {
  // static bool checkBoxSelected = false;
  final Order order;

  const OrderCard({super.key, required this.order});

  // bool checkBoxSelected = false;

  // bool checkBoxVisible = OrdersPage.checkboxvisible;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
            onTap: () {
              Get.to(ProjectProductOrdersCard(
                  products: order.products, id: order.id));
            },
            child: Card(
              child: ListTile(
                leading: Text(
                  "#${order.id}",
                  style: const TextStyle(fontSize: 20),
                ),
                title: Text("created at :${order.date.substring(0, 10)}"),
                subtitle: Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: MainPage.orangeColor,
                    ),
                    Text(order.location)
                  ],
                ),
                trailing: Text(
                  order.status!,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            )),
      ),
    );
  }
}
