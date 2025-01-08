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
  Future<List> getProductByCategory() async {
    final response = await http.post(
        Uri.parse(
            "http://192.168.1.110:8000/api/auth/get_products_by_category"),
        body: {
          "token":
              "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjExMDo4MDAwL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNzM1ODQ0Mzg0LCJleHAiOjE3MzU5MDQzODQsIm5iZiI6MTczNTg0NDM4NCwianRpIjoiZm9RRjV1V0tRUzVBR01jcSIsInN1YiI6IjgiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.8Dbt2Y5i237OAm7tcvB4MOPkTiebEdCLGdLU1iuEj3M",
          "category": Category
        });
    print(response.body);
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
          future: getProductByCategory(),
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
                      return ProjectProductCartCardHome(
                        name: data[index]["name"],
                        id: data[index]["id"],
                        price: data[index]["price"],
                        imageLink: "assets/images/product.png",
                        category: "food",
                      );
                    });
              }
            }
          }),
    );
  }
}
