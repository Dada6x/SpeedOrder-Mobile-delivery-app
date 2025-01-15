import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
// import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
// import 'package:mamamia_uniproject/Controllers/favoriteController.dart';
// import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';
import 'package:http/http.dart' as http;
import 'package:mamamia_uniproject/Screens/productpage.dart';

import '../Auth/model/model.dart';

// ignore: must_be_immutable
class FavoriteCard extends StatelessWidget {
  var id;
  var Favid;
  String imageLink;
  String name;
  var price;
  String category;
  FavoriteCard({
    super.key,
    required this.Favid,
    required this.id,
    required this.name,
    required this.price,
    required this.imageLink,
    required this.category,
  }); //default constructor
  //comstructor used for list

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductPage(
          id: id,
        ));
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // the color of the card
                color: Theme.of(context).colorScheme.secondary),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                          //! the product image @cart
                          image: AssetImage(imageLink),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //! product name @cart
                          name,
                          style: const TextStyle(fontSize: 25),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            //! producct price @cart
                            '$price \$',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () async {
                              String? token =
                                  await Get.find<Model>().getToken();
                              final response = http.post(
                                  Uri.parse(
                                      "http://192.168.1.110:8000/api/auth/delete_from_favorite"),
                                  body: {
                                    "token": token,
                                    "favorite_id": "$Favid"
                                  });
                            },
                            icon: Icon(
                              Icons.close,
                              color: Theme.of(context).colorScheme.primary,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
