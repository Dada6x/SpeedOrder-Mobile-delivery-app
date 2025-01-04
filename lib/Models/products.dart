import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart ' as http;
import 'package:mamamia_uniproject/Auth/model.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';

class Productsgetter extends StatefulWidget {
  const Productsgetter({super.key});

  @override
  State<Productsgetter> createState() => _ProductsgetterState();
}

class _ProductsgetterState extends State<Productsgetter> {
  Future<List> getProducts() async {
    final response = await http.post(
        Uri.parse("http://192.168.1.110:8000/api/auth/get_products"),
        body: {
          "token":
              "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjExMDo4MDAwL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNzM1ODQ0Mzg0LCJleHAiOjE3MzU5MDQzODQsIm5iZiI6MTczNTg0NDM4NCwianRpIjoiZm9RRjV1V0tRUzVBR01jcSIsInN1YiI6IjgiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.8Dbt2Y5i237OAm7tcvB4MOPkTiebEdCLGdLU1iuEj3M"
        });
    print(response.body);
    List productList = jsonDecode(response.body);
    Get.find<HomePageProductController>().productList.addAll(productList);
    return productList;
  }

  Future<void> _refresh() async {
    Get.find<HomePageProductController>().productList = [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Get.find<HomePageProductController>().productList.isEmpty
        ? RefreshIndicator(
            onRefresh: () {
              return Future(() {
                setState(() {});
              });
            },
            child: FutureBuilder(
                future: getProducts(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  if (data == null) {
                    return const Center(child: LinearProgressIndicator());
                  } else {
                    var datalength = data.length;
                    if (datalength == 0) {
                      return const Center(
                        child: Text('no data found'),
                      );
                    } else {
                      return SizedBox(
                        width: Get.find<Model>().screenWidth(context),
                        height: Get.find<Model>().screenHeight(context) * 0.9,
                        child: ListView.builder(
                            itemCount: datalength,
                            itemBuilder: (context, index) {
                              return ProjectProductCartCardHome(
                                name: data[index]["name"],
                                id: data[index]["id"],
                                price: data[index]["price"],
                                imageLink: "assets/images/product.png",
                                category: "food",
                              );
                            }),
                      );
                    }
                  }
                }),
          )
        : SizedBox(
            width: Get.find<Model>().screenWidth(context),
            height: Get.find<Model>().screenHeight(context) * 0.9,
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                  itemCount:
                      Get.find<HomePageProductController>().productList.length,
                  itemBuilder: (context, index) {
                    return ProjectProductCartCardHome(
                      name: Get.find<HomePageProductController>()
                          .productList[index]["name"],
                      id: Get.find<HomePageProductController>()
                          .productList[index]["id"],
                      price: Get.find<HomePageProductController>()
                          .productList[index]["price"],
                      imageLink: "assets/images/product.png",
                      category: "food",
                    );
                  }),
            ),
          );
  }
}
