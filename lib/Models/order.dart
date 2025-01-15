import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';

class Order {
  final String date;
  final String? status;
  final List<Product> products;
  Order({required this.date, required this.products,this.status});
}
