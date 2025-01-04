import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/components/Stores_card.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:http/http.dart' as http;

class StoresPage extends StatefulWidget {
  const StoresPage({super.key});

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  Future<void> refresh() async {
    Get.find<HomePageProductController>().storeList = [];
    setState(() {});
  }

  Future<List> getStores() async {
    final response = await http.post(
        Uri.parse("http://192.168.1.110:8000/api/auth/get_companies"),
        body: {
          "token":
              "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjExMDo4MDAwL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNzM1ODQ0Mzg0LCJleHAiOjE3MzU5MDQzODQsIm5iZiI6MTczNTg0NDM4NCwianRpIjoiZm9RRjV1V0tRUzVBR01jcSIsInN1YiI6IjgiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.8Dbt2Y5i237OAm7tcvB4MOPkTiebEdCLGdLU1iuEj3M"
        });

    List list = jsonDecode(response.body);
    Get.find<HomePageProductController>().storeList.addAll(list);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Stores",
            style: TextStyle(fontSize: 30),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: searchStores());
                },
                icon: const Icon(
                  Icons.search,
                  size: 25,
                ))
          ],
        ),
        body: Get.find<HomePageProductController>().storeList.isEmpty
            ? RefreshIndicator(
                onRefresh: () {
                  return Future(() {
                    setState(() {});
                  });
                },
                child: FutureBuilder(
                    future: getStores(),
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
                                return StoresCard(
                                  id: data[index]["id"],
                                  name: data[index]["name"],
                                  location: data[index]["location"],
                                  phoneNumber: data[index]["phone"],
                                );
                              });
                        }
                      }
                    }),
              )
            : RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                    itemCount:
                        Get.find<HomePageProductController>().storeList.length,
                    itemBuilder: (context, index) {
                      return StoresCard(
                        id: Get.find<HomePageProductController>()
                            .storeList[index]["id"],
                        name: Get.find<HomePageProductController>()
                            .storeList[index]["name"],
                        location: Get.find<HomePageProductController>()
                            .storeList[index]["location"],
                        phoneNumber: Get.find<HomePageProductController>()
                            .storeList[index]["phone"],
                      );
                    }),
              ));
  }
}

class searchStores extends SearchDelegate {
  @override
  Future<List> getFilteredList(String search) async {
    final response = await http.post(
        Uri.parse("http://192.168.1.110:8000/api/auth/search_in_companies"),
        body: {
          "token":
              "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjExMDo4MDAwL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNzM1ODQ0Mzg0LCJleHAiOjE3MzU5MDQzODQsIm5iZiI6MTczNTg0NDM4NCwianRpIjoiZm9RRjV1V0tRUzVBR01jcSIsInN1YiI6IjgiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.8Dbt2Y5i237OAm7tcvB4MOPkTiebEdCLGdLU1iuEj3M",
          "search": search
        });
    List list = jsonDecode(response.body);
    return list;
  }

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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //app bar body before pressing search icon on keyboard
    if (query != "") {
      return FutureBuilder(
          future: getFilteredList(query),
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
                return ListView.builder(
                    itemCount: datalength,
                    itemBuilder: (context, index) {
                      return StoresCard(
                        name: data[index]["name"],
                        id: data[index]["id"],
                        location: data[index]["location"],
                        phoneNumber: data[index]["phone"],
                      );
                    });
              }
            }
          });
    } else {
      return Center(
        child: Text(
          "Fill the Search Bar to find Your desired Store !!",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: Theme.of(context).colorScheme.primary),
        ),
      );
    }
  }
}
