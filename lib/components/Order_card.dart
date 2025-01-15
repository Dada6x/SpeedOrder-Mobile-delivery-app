import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mamamia_uniproject/Models/order.dart';
import 'package:mamamia_uniproject/components/Product_card_ordersPage.dart';

class OrderCard extends StatelessWidget {
  // static bool checkBoxSelected = false;
  final Order order;

  OrderCard({required this.order});
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
            Get.to(ProjectProductOrdersCard());
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.secondary),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    //! product name @cart
                    order.date,
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
