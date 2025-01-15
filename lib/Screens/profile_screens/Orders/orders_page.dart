import 'package:flutter/material.dart';
import 'package:mamamia_uniproject/Models/order.dart';
import 'package:mamamia_uniproject/components/Order_card.dart';
import 'package:http/http.dart' as http;

import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';

class OrdersPage extends StatefulWidget {
  static bool checkboxvisible = false;
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool deleteVisible = false;
    tabController.index == 0 ? deleteVisible = true : deleteVisible = false;
    return Scaffold(
      // floatingActionButton: deleteVisible
      //     ? Row(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: [
      //           IconButton(
      //               onPressed: () {
      //                 setState(() {

      //                 });
      //               },
      //               icon:const Icon(Icons.delete)),
      //           IconButton(
      //               onPressed: () {
      //                 setState(() {
      //                   bool checkBoxVisible = OrdersPage.checkboxvisible;
      //                   checkBoxVisible = !checkBoxVisible;
      //                   OrdersPage.checkboxvisible = checkBoxVisible;
      //                   // OrderCard.
      //                 });
      //               },
      //               icon:const Icon(Icons.edit)),
      //         ],
      //       )
      //     : null,
      appBar: AppBar(
        centerTitle: true,
        title: Text(tabController.index == 0 ? "Mail" : "OnGoing"),
        bottom: TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Theme.of(context).colorScheme.secondary,
            tabs: [
              Tab(
                text: "Pending",
                icon: Icon(
                  Icons.pending_actions,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Tab(
                  text: "AllOrders",
                  icon: Icon(
                    Icons.done_all,
                    color: Theme.of(context).colorScheme.primary,
                  )),
            ]),
      ),
      body: TabBarView(controller: tabController, children: [

        ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return OrderCard();
          },
        ),
        ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return OrderCard();
          },
        ),
      ]),
    );
  }
}

      // body: ListView.builder(
      //   itemCount: Get.find<OrdersController>().orderedCardsList.length,
      //   itemBuilder: (context, index) {
      //     return Get.find<OrdersController>().orderedCardsList[index];
      //   },
      // ),