import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class CategoriesPage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  String Category;
  List? filteredList;
  Future<List> getProductByCategory() async {
    String? token = await Get.find<Model>().getToken();
    final response = await http.post(
      Uri.parse("http://10.0.2.2:8000/api/auth/get_products_by_category"),
      body: {
        "token": token,
        "category": Category,
      },
    );
    if (response.statusCode == 200) {
      print("done");
      print("picked category is :$Category");
    }
    //  print(response.body);
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

                        category: data[index]["category"],
                        isFavorite: data[index]["is_favorite"],
                      );
                    });
              }
            }
          }),
    );
  }
}
