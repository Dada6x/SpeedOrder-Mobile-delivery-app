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
        Uri.parse("http://192.168.151.48:8000/api/auth/get_products"),
        body: {
          "token":
              "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xNTEuNDg6ODAwMC9hcGkvcmVnaXN0ZXIiLCJpYXQiOjE3MzYyNDA5NzksImV4cCI6MTczNjI0NDU3OSwibmJmIjoxNzM2MjQwOTc5LCJqdGkiOiJiTTI1bUNBbjhEZDg4OHRBIiwic3ViIjoiMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.6tXFc7bEr97OQ0e_Wx2CgOgRBJ-iIgEagW_aI4yzIBA"
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
                                category: data[index]["category"],
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
