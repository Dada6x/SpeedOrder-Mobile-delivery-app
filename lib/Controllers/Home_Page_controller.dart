import 'package:get/get.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';

class HomePageProductController extends GetxController {
  List storeList = [];
  void productisFavored(Product p) {
    p.isFavored = !p.isFavored;
    update();
  }

  List productList = [];
}
