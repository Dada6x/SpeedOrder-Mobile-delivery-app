import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/cart_controller.dart';
import 'package:mamamia_uniproject/Models/order.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';
import 'package:mamamia_uniproject/components/Product_card_ordersPage.dart';

//changed the added variables into products and when a product is added the card is created an added to the page
class OrdersController extends GetxController {
  var orderedItems = <Product>[].obs;
  var orders = <Order>[].obs;
  var orderDate = <String>[].obs;

  List<Product> cartItems = Get.find<CartController>().cartItems;
  var orderedCardsList = <ProjectProductOrdersCard>[].obs;

  void addToHistory() {
    orderedItems.addAll(cartItems);
    print("length of orders cart list:${cartItems.length}");
    print("length of order cards list:${orderedCardsList.length}");
    for (var element in cartItems) {
      element.purchaseDate = DateTime.now().toString().split(" ")[0];
      // element.orderCard = ordercard(product: element);
      orderedCardsList.add(element.orderCard!);
    }
  }

  void deleteOrder(String orderDate) {
    for (var element in orders) {
      if (element.date == orderDate) {
        orders.remove(element);
      }
    }
  }

  void addOrdersFromApi(List<Order> comingOrders) {
    for (var element in comingOrders) {
      if (containsOrder(element.date)) {
        comingOrders.remove(element);
      } else
        orders.add(element);
    }
  }

  void addOrderFromCart(List<Product> proudcts) {
    String Date = DateTime.now().toString().split(" ")[0];
    Order newOrder = Order(date: Date, products: proudcts);
    orders.add(newOrder);
  }

  bool containsOrder(String Date) {
    for (var element in orders) {
      if (element.date == Date) {
        return true;
      }
    }
    return false;
  }
}
