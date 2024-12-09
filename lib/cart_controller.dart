import 'package:get/get.dart';

class CartItem {
  final String productName;
  final String description;
  final double price;
  final String imageAsset;

  CartItem({
    required this.productName,
    required this.description,
    required this.price,
    required this.imageAsset,
  });
}

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  double get totalPrice =>
      cartItems.fold(0.0, (sum, item) => sum + item.price);

  void addToCart(CartItem item) {
    cartItems.add(item);
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
  }
}
