import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/Controllers/orders_controller.dart';
import 'package:mamamia_uniproject/Models/order.dart';
import 'package:mamamia_uniproject/components/Order_card.dart';
import 'package:http/http.dart' as http;
import 'package:mamamia_uniproject/components/Order_card.dart';

class OrdersPage extends StatefulWidget {
  static bool checkboxvisible = false;
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

Future<List> GetOrders(String status) async {
  String? token = await Get.find<Model>().getToken();
  final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/auth/get_total_price"),
      body: {"token": token});
  List<Order> orders = jsonDecode(response.body);
  if (status == "Pending") {
    Get.find<OrdersController>().addOrdersFromApi(orders);
  }
  return orders;
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
        FutureBuilder(
          future: GetOrders("Pending"),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              var datalength = data.length;
              if (datalength == 0) {
                return const Center(
                  child: Text('no data found'),
                );
              } else {
                return ListView.builder(
                    itemCount: datalength,
                    itemBuilder: (context, index) {
                      return OrderCard(
                        order: data[index],
                      );
                    });
              }
            }
          },
        ),
        FutureBuilder(
          future: GetOrders("Completed"),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              var datalength = data.length;
              if (datalength == 0) {
                return const Center(
                  child: Text('no data found'),
                );
              } else {
                return ListView.builder(
                    itemCount: datalength,
                    itemBuilder: (context, index) {
                      return OrderCard(
                        order: data[index],
                      );
                    });
              }
            }
          },
        ),
        // ListView.builder(
        //   itemCount: 4,
        //   itemBuilder: (context, index) {
        //     return OrderCard();
        //   },
        // ),
      ]),
    );
  }
}
