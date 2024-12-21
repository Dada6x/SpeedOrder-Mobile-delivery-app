import 'package:get/get.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';

class User {
  String username;
  int number;
  String location;
  String password;
  String? imageLink;
  List<Product>? favProducts;
  List<Product>? cartProducts;
  User.signUp(this.username, this.number, this.password, this.location,
      {this.imageLink});
  User.signIn(this.username, this.number, this.password, this.location,
      this.imageLink, this.cartProducts, this.favProducts) {
    /*if (favProducts!.isNotEmpty) {
      for (Product p in favProducts!) {
`        Get.find<FavoriteController>().addToCart(p);
      }
    }
    if (cartProducts!.isNotEmpty) {
      for (Product p in cartProducts!) {
        Get.find<CartController>().addToCart(p);
      }
    }*/
  }
}

class Usercontroller extends GetxController {
  User? user;
}
