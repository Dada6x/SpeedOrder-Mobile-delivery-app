import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart ' as http;
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';
import 'package:mamamia_uniproject/main.dart';

class Productsgetter extends StatefulWidget {
  const Productsgetter({super.key});

  @override
  State<Productsgetter> createState() => _ProductsgetterState();
}

class _ProductsgetterState extends State<Productsgetter> {
  Future<List> getProducts() async {
    String? token = await Get.find<Model>().getToken();
    print(token);
    final response = await http.post(
      Uri.parse("http://10.0.2.2:8000/api/auth/get_products"),
      body: {
        "token": token,
      },
    );
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
                    var dataLength = data.length;
                    if (dataLength == 0) {
                      return const Center(
                        child: Text('no data found'),
                      );
                    } else {
                      return SizedBox(
                        width: screenWidth(context),
                        height: screenHeight(context) * 0.9,
                        child: ListView.builder(
                            itemCount: dataLength,
                            itemBuilder: (context, index) {
                              return ProjectProductCartCardHome(
                                name: data[index]["name"],
                                id: data[index]["id"],
                                price: data[index]["price"],
                                imageLink: "assets/images/product.png",
                                category: data[index]["category"],
                                isFavorite: data[index]["is_favorite"],
                              );
                            }),
                      );
                    }
                  }
                }),
          )
        : SizedBox(
            width: screenWidth(context),
            height: screenHeight(context) * 0.9,
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
                      category: Get.find<HomePageProductController>()
                          .productList[index]["category"],
                      isFavorite: Get.find<HomePageProductController>()
                          .productList[index]["is_favorite"],
                    );
                  }),
            ),
          );
  }
}
