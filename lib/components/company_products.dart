import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Screens/productpage.dart';

// ignore: must_be_immutable
class ProducInCompanyPage extends StatelessWidget {
  String text;
  var id;
  ProducInCompanyPage({super.key, required this.text, required this.id});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductPage(id: id));
      },
      child: Container(
        margin: const EdgeInsets.only(
          right: 10,
        ),
        //decoration: BoxDecoration(border: Border.all(color: Colors.green)),
        width: 80,
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 80,
                height: 80,
                child: Image.asset(
                  "assets/images/product.png",
                  fit: BoxFit.cover,
                )),
            AutoSizeText(
              minFontSize: 10,
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
