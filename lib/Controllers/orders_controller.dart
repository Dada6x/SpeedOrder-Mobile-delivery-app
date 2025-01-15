import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/cart_controller.dart';
import 'package:mamamia_uniproject/Models/order.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';
import 'package:mamamia_uniproject/components/Product_card_ordersPage.dart';

//changed the added variables into products and when a product is added the card is created an added to the page
class OrdersController extends GetxController {
  // var orderedItems = <Product>[].obs;
  // var orderDate = <String>[].obs;

  var orders = <Order>[].obs;
  List<Product> cartItems = Get.find<CartController>().cartItems;
  var orderedCardsList = <ProjectProductOrdersCard>[].obs;
  var completedOrders = <Order>[].obs;

  void deleteOrder(String orderDate) {
    for (var element in orders) {
      if (element.date == orderDate) {
        orders.remove(element);
      }
    }
  }

  void addOrderHistoryFromApi(List<Order> comingOrders) {
    for (var element in comingOrders) {
      if (containsCompletedOrder(element.date)) {
        comingOrders.remove(element);
      } else {
        completedOrders.add(element);
      }
    }
  }

  void addPendingOrdersFromApi(List<Order> comingOrders) {
    for (var element in completedOrders) {
      if (containsPendingOrder(element.date)) {
        comingOrders.remove(element);
      } else {
        orders.add(element);
      }
    }
  }

  void addPendingOrderFromCart() {
    String Date = DateTime.now().toString().split(" ")[0];
    List<Product> currentcartItems = Get.find<CartController>().cartItems;

    Order newOrder = Order(date: Date, products: currentcartItems);
    orders.add(newOrder);
  }

  void sortOrderLists(List<Order> Orders) {
    var pending = <Order>[];
    var completed = <Order>[];
    for (var element in Orders) {
      element.status == "Pending"
          ? pending.add(element)
          : completed.add(element);
    }
  }

  bool containsPendingOrder(String Date) {
    for (var element in orders) {
      if (element.date == Date) {
        return true;
      }
    }
    return false;
  }

  bool containsCompletedOrder(String Date) {
    for (var element in completedOrders) {
      if (element.date == Date) {
        return true;
      }
    }
    return false;
  }
}

  // void addToHistory() {
  //   orderedItems.addAll(cartItems);
  //   print("length of orders cart list:${cartItems.length}");
  //   print("length of order cards list:${orderedCardsList.length}");
  //   for (var element in cartItems) {
  //     element.purchaseDate = DateTime.now().toString().split(" ")[0];
  //     // element.orderCard = ordercard(product: element);
  //     orderedCardsList.add(element.orderCard!);
  //   }
  // }