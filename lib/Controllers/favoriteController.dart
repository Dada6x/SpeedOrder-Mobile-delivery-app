import 'package:get/get.dart';
import 'package:mamamia_uniproject/components/favorite_card.dart';

class FavoriteController extends GetxController {
  var favoriteItems = [];
  var favoriteCardsList = <FavoriteCard>[].obs;

  /* void addToFavorite(Product p) {
    print("listLength is :${favoriteItems.length + 1}");
    bool isFavorite = isAfavoriteAlr(p);
    if (!isFavorite) {
      favoriteItems.add(p);
      p.favoriteCard = FavoriteCard(product: p);
      favoriteCardsList.add(p.favoriteCard!);
    }
    if (isFavorite) {
      print("Product Already in ");
    }
  }

  void removeFromCart(Product item) {
    favoriteItems.remove(item);
    favoriteCardsList.remove(item.favoriteCard);
    item.favoriteCard = null;
    print("length of favorite list:${favoriteCardsList.length}");
  }

  isAfavoriteAlr(Product p) {
    if (favoriteItems.contains(p)) {
      return true;
    } else {
      return false;
    }
  }*/
}
