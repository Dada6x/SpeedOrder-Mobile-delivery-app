import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class FavoriteButton extends StatefulWidget {
  var id;
  bool isFavorite;

  FavoriteButton({super.key, required this.id, required this.isFavorite});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomePageProductController(),
        builder: (controller) => IconButton(
            onPressed: () async {
              String? token = await Get.find<Model>().getToken();
              if (!widget.isFavorite) {
                // ignore: unused_local_variable
                final response = await http.post(
                    Uri.parse(
                        "http://192.168.1.110:8000/api/auth/add_to_favorite"),
                    body: {"product_id": "${widget.id}", "token": token});
                Get.snackbar(
                    "Product #${widget.id}", "is in your FavoriteList");
              }
            },
            icon: widget.isFavorite
                ? Icon(
                    Icons.favorite,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : const Icon(Icons.favorite_outline)));
  }
}
