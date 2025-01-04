import 'package:get/get.dart';
import 'package:mamamia_uniproject/components/Product_card_CartPage.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';

//changed the added variables into products and when a product is added the card is created an added to the page
class CartController extends GetxController {
  var cartItems = <Product>[].obs;
  var cartCardsList = <ProjectProductCartCard>[].obs;
 // double get totalPrice => cartItems.fold(0.0, (sum, item) => sum + item.price);

  void addToCart(Product p) {
    p.isInCart = inList(p);
    if (!p.isInCart) {
      cartItems.add(p);
      p.cartCard = ProjectProductCartCard(product: p);
      cartCardsList.add(p.cartCard!);
      print("listLength is :${cartItems.length}");
      print("length of cart cards list:${cartCardsList.length}");
    }
    if (p.isInCart) {
      print("Product Already in ");
    }
  }

  void removeFromCart(Product item) {
    cartItems.remove(item);
    cartCardsList.remove(item.cartCard);
    item.cartCard = null;
    print("length of cart list:${cartItems.length}");
    print("length of cart cards list:${cartCardsList.length}");
  }

  void removeAllFromCart() {
    List toRemove = [];
    List toRemovecard = [];
    for (Product p in cartItems) {
      toRemove.add(p);
    }
    for (ProjectProductCartCard p in cartCardsList) {
      toRemovecard.add(p);
    }
    cartItems.removeWhere((e) => toRemove.contains(e));
    cartCardsList.removeWhere((e) => toRemovecard.contains(e));
    print("length of cart list:${cartItems.length}");
    print("length of cart cards list:${cartCardsList.length}");
  }

  inList(Product p) {
    if (cartItems.contains(p)) {
      return true;
    } else {
      return false;
    }
  }
}
