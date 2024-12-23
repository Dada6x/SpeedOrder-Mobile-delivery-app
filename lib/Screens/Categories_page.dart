import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';

// ignore: must_be_immutable
class CategoriesPage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  String Category;
  List<Product>? filteredList;
  // ignore: non_constant_identifier_names
  CategoriesPage({super.key, required this.Category}) {
    filteredList = Get.find<HomePageProductController>()
        .productList()
        .where(
            (element) => element.category.isCaseInsensitiveContains(Category))
        .toList();
    print(Category);
  }
  @override
  Widget build(BuildContext context) {
    String chosenCategory = "$Category${" "}".tr;
    return Scaffold(
      appBar: NormalAppBar(chosenCategory),
      body: ListView.builder(
          itemCount: filteredList!.length,
          itemBuilder: (context, index) {
            return ProjectProductCartCardHome(product: filteredList![index]);
          }),
    );
  }
}
