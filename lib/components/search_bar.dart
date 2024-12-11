import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Screens/search_page.dart';

Widget ProjectSearchBar(String type) {
  return Padding(
    padding: EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 20),
    child: SearchBar(
      onChanged: (value) {},
      onTap: () {
        if (type == "directing") {
          directing();
        }
      },
      leading: const Icon(
        Icons.search,
      ),
      hintText: 'What are you looking for?'.tr,
      hintStyle: const WidgetStatePropertyAll(TextStyle(color: Colors.grey)),
      shape: const WidgetStatePropertyAll(ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(45)))),
    ),
  );
}

void directing() {
  Get.to(SearchPage());
}
//! make the searchBar logic for search for the shit