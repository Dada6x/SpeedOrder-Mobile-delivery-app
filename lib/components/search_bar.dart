import 'package:flutter/material.dart';
import 'package:get/get.dart';


Widget ProjectSearchBar() {
  return  Padding(
    padding: const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 20),
    child: SearchBar(
      leading: const Icon(
        Icons.search,
      ),
      hintText: 'Whats you\'re looking for?'.tr,
      hintStyle: const WidgetStatePropertyAll(TextStyle(color: Colors.grey)),
      shape: const WidgetStatePropertyAll(ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(45)))),
    ),
  );
}
//! make the searchBar logic for search for the shit