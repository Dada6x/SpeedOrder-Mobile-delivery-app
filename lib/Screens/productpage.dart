import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';
import 'package:http/http.dart' as http;
import 'package:mamamia_uniproject/main_page.dart';

// ignore: must_be_immutable
class ProductPage extends StatelessWidget {
  var id;
  ProductPage({super.key, required this.id});
  Future<List> getDetails(var id) async {
    String? token = await Get.find<Model>().getToken();
    final response = await http.post(
        Uri.parse("http://192.168.1.110:8000/api/auth/get_details-for-product"),
        body: {"token": token, "id": "$id"});
    List product = [];
    product.add(jsonDecode(response.body));
    print(product[0]);
    return product;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      //! share extention here
                    },
                    icon: const Icon(Icons.share)),
              ),
              // const Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: LikeButton(),
              // )
            ],
          )
        ],
      ),
      floatingActionButton: ProjectButton(
        //todo Ward what  IS THAT
        function: () async {
          final response =
              http.post(Uri.parse(""), body: {"token": "", "product_id": id});
        },
        text: 'Add to Cart'.tr,
        width: double.infinity,
      ),
      body: FutureBuilder<List>(
          future: getDetails(id),
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
                Product product = Product(
                    data[0]["id"],
                    data[0]["name"],
                    data[0]["price"],
                    data[0]["details"],
                    data[0]["photo_path"],
                    data[0]["company_name"],
                    data[0]["count"]);
                return Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          const ProductBackgroundImage(),
                          ProductImage(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            productImage: "assets/images/product.png",
                          ),
                          ProductInfoCardPage(
                            screenHeight: screenHeight,
                            product: product,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }
          }),
    );
  }
}

class ProductInfoCardPage extends StatelessWidget {
  const ProductInfoCardPage(
      {super.key, required this.screenHeight, required this.product});

  final double screenHeight;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: screenHeight / 3 - 20, left: 20, right: 20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      height: screenHeight / 2,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          /*  ProjectProductCartCardHome(product: product)
              .iconType(context, product.category)!,*/
          const SizedBox(
            height: 10,
          ),
          Text(
            product.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 10,
          ),
          const Spacer(
            flex: 1,
          ),
          ExtraInfo(leading: "Company:", title: product.company),
          ExtraInfo(leading: "Available offers:", title: "${product.count}"),
          ExtraInfo(leading: "Price:", title: "${product.price} \$"),
        ],
      ),
    );
  }
}

class ExtraInfo extends StatelessWidget {
  String leading;
  String title;
  ExtraInfo({super.key, required this.leading, required this.title});
  TextStyle leadingtextStyle =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
  TextStyle titletextStyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: MainPage.orangeColor);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        leading,
        style: leadingtextStyle,
      ),
      title: Text(
        title,
        style: titletextStyle,
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.productImage,
  });
  final String productImage;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      height: screenHeight / 3,
      width: screenWidth,
      //! Background image icon
      productImage,
      fit: BoxFit.contain,
    );
  }
}

class ProductBackgroundImage extends StatelessWidget {
  const ProductBackgroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/food2.png',
        color: Colors.black12,
        repeat: ImageRepeat.repeat,
        height: double.infinity,
      ),
    );
  }
}
