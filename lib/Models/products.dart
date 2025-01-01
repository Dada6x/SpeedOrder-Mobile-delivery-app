import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart ' as http;
import 'package:mamamia_uniproject/Auth/model.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';

class Productsgetter extends StatelessWidget {
  const Productsgetter({super.key});

  Future<List> getProducts() async {
    final response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));
    print(response.body);
    List productList = jsonDecode(response.body);
    Get.find<HomePageProductController>().productList.addAll(productList);
    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                        name: data[index]["title"],
                        price: data[index]["price"],
                        imageLink: data[index]["image"],
                        category: data[index]["category"],
                      );
                    }),
              );
            }
          }
        });
  }
}
