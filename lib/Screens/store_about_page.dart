import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/components/Stores_card.dart';
import 'package:mamamia_uniproject/components/company_products.dart';
import 'package:mamamia_uniproject/main_page.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class StoreAboutPage extends StatelessWidget {
  Company company;
  StoreAboutPage({super.key, required this.company});
  Future<List> getProudctsInStore(var id) async {
    String? token = await Get.find<Model>().getToken();
    final response = await http.post(
      Uri.parse("http://10.0.2.2:8000/api/auth/get_products_of_company"),
      body: {
        "company_id": "$id",
        "token": token,
      },
    );
    List about = jsonDecode(response.body);
    return about;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("About"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: screenHeight / 3.2,
              child: Stack(
                children: [
                  Material(
                    elevation: 1,
                    child: StoreImage(
                      storeImage: "assets/images/Store.png",
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Material(
                              color: Theme.of(context).colorScheme.secondary,
                              type: MaterialType.circle,
                              elevation: 1,
                              child: const CircleAvatar(
                                radius: 55,
                                backgroundImage:
                                    AssetImage("assets/images/Store.png"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                ListTile(
                  leading:
                      Icon(Icons.factory_outlined, color: MainPage.orangeColor),
                  title: Text(
                    company.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.phone, color: MainPage.orangeColor),
                  title: Text(
                    company.phoneNumber,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.location_pin,
                    color: MainPage.orangeColor,
                  ),
                  title: Text(
                    company.location,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
            Card(
              child: ListTile(
                title: Text(
                  "Products:",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700),
                ),
                subtitle: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 8),
                    child: FutureBuilder(
                        future: getProudctsInStore(company.id),
                        builder: (context, snapshot) {
                          var data = snapshot.data;
                          if (data == null) {
                            return const Center(
                                child: LinearProgressIndicator());
                          } else {
                            var datalength = data.length;
                            if (datalength == 0) {
                              return const Center(
                                child: Text('no data found'),
                              );
                            } else {
                              return SizedBox(
                                height: 120,
                                width: screenWidth,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: datalength,
                                    itemBuilder: (context, index) {
                                      return ProducInCompanyPage(
                                          id: data[index]["id"],
                                          text: data[index]["name"]);
                                    }),
                              );
                            }
                          }
                        })
                    /*SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProducInCompanyPage("penis cage"),
                        ProducInCompanyPage("butt Plugs"),
                        ProducInCompanyPage("dildos"),
                        ProducInCompanyPage("anal beads"),
                      ],
                    ),
                  ),*/
                    ),
              ),
            )
          ],
        ));
  }
}

class StoreImage extends StatelessWidget {
  const StoreImage({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.storeImage,
  });
  final String storeImage;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      height: screenHeight / 4,
      width: screenWidth,
      //! Background image icon
      storeImage,
      fit: BoxFit.cover,
    );
  }
}
