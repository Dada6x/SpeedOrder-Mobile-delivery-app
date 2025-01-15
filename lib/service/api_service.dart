import 'package:flutter/material.dart';
import 'package:mamamia_uniproject/model/api_endpoints.dart';

class ApiService extends StatelessWidget {
  // const ApiService({super.key});
  final String apiHead =
      "http://127.0.0.1:8000/api/auth/add_to_cart?token=  &product_id=6&count=123456";
  final String apiRequest = "add_to_cart";

  @override
  Widget build(BuildContext context) {
  String api = ApiEndpoints.AddToCartAPI("2", "2");
    // final response = http.post(Uri.parse());
    return const Placeholder();
  }
}
