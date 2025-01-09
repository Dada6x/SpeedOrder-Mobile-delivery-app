import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class CategoriesPage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  String Category;
  List? filteredList;
  Future<List> getProductByCategory(String category) async {
    final response = await http.post(
        Uri.parse(
            "http://192.168.151.48:8000/api/auth/get_products_by_category"),
        body: {
          "token":
              "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xNTEuNDg6ODAwMC9hcGkvcmVnaXN0ZXIiLCJpYXQiOjE3MzYyNDA5NzksImV4cCI6MTczNjI0NDU3OSwibmJmIjoxNzM2MjQwOTc5LCJqdGkiOiJiTTI1bUNBbjhEZDg4OHRBIiwic3ViIjoiMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.6tXFc7bEr97OQ0e_Wx2CgOgRBJ-iIgEagW_aI4yzIBA",
          "category": category,
        });
    List productList = jsonDecode(response.body);
    return productList;
  }

  // ignore: non_constant_identifier_names
  CategoriesPage({super.key, required this.Category});
  @override
  Widget build(BuildContext context) {
    String chosenCategory = "$Category${" "}".tr;
    return Scaffold(
      appBar: NormalAppBar(chosenCategory),
      body: FutureBuilder(
          future: getProductByCategory(Category),
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
                print(data);
                return ListView.builder(
                    itemCount: datalength,
                    itemBuilder: (context, index) {
                      return ProjectProductCartCardHome(
                        name: data[index]["name"],
                        id: data[index]["id"],
                        price: data[index]["price"],
                        imageLink: "assets/images/product.png",
                        category: data[index]["category"],
                      );
                    });
              }
            }
          }),
    );
  }
}
