import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mamamia_uniproject/Models/order.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/Orders/orders_page.dart';
import 'package:mamamia_uniproject/components/Product_card_ordersPage.dart';

class OrderCard extends StatefulWidget {
  static bool checkBoxSelected = false;
  final Order order;

  OrderCard({required this.order});
  @override
  State<OrderCard> createState() => _OrderCardState();
}

void deleteProductOrder() {}

class _OrderCardState extends State<OrderCard> {
  bool checkBoxSelected = false;
  bool checkBoxVisible = OrdersPage.checkboxvisible;
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
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    //! product name @cart
                    "Date",
                    style: TextStyle(fontSize: 25),
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
                OrdersPage.checkboxvisible
                    ? Checkbox(
                        value: OrdersPage.checkboxvisible
                            ? checkBoxSelected
                            : OrderCard.checkBoxSelected,
                        onChanged: (newValue) {
                          {
                            setState(() {
                              checkBoxSelected = newValue!;
                            });
                          }
                        })
                    : const SizedBox(),

                //         // Padding(
                //         //   padding: const EdgeInsets.all(8.0),
                //         //   child: Row(
                //         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         //     children: [
                //         // Text(
                //         //   //! product price @cart
                //         //   '${widget.product.price} \$',
                //         //   style: TextStyle(
                //         //       color: Theme.of(context).colorScheme.primary,
                //         //       fontSize: 20,
                //         //       fontWeight: FontWeight.bold),
                //         // ),
                //         // Text(
                //         //   //! product price @cart
                //         //   '${widget.product.purchaseDate}',
                //         //   style: TextStyle(
                //         //       color: Theme.of(context).colorScheme.primary,
                //         //       fontSize: 15,
                //         //       fontWeight: FontWeight.bold),
                //         // ),
                //         // ],
                //         // ),
                //         // ),
                //       ],
                //     ),
                //   ),
                // ),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
