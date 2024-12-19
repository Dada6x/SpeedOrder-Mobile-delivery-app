import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';
import 'package:mamamia_uniproject/main_page.dart';

class ProjectSearchBar extends StatefulWidget {
  const ProjectSearchBar({super.key});

  @override
  State<ProjectSearchBar> createState() => _ProjectSearchBarState();
}

class _ProjectSearchBarState extends State<ProjectSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 20),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
          child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                  hintText: "What are you looking for?".tr,
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: MainPage.orangeColor,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              onTap: () {
                showSearch(
                    context: context,
                    delegate:
                        search()); //removed search page and used search delegate instead
              }),
        ));
  }
}

//widget thats used in search
class search extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search'.tr;
  @override
  List<Widget>? buildActions(BuildContext context) {
    //app bar actions in search page
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.remove))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //app bar leading in search page
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    //app bar body after pressing the search icon on keyborad
    List<Product> filteredList = Get.find<HomePageProductController>()
        .productList()
        .where((element) => element.name.isCaseInsensitiveContains(query))
        .toList();
    return ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          return filteredList[index].homeCard;
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //app bar body before pressing search icon on keyboard
    if (query != "") {
      List<Product> filteredList = Get.find<HomePageProductController>()
          .productList()
          .where((element) => element.name.isCaseInsensitiveContains(query))
          .toList();
      return ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            return filteredList[index].homeCard;
          });
    } else {
      return ListView.builder(
          itemCount: Get.find<HomePageProductController>().productList().length,
          itemBuilder: (context, index) {
            return Get.find<HomePageProductController>()
                .productList()[index]
                .homeCard;
          });
    }
  }
}
//! make the searchBar logic for search for the shit
