import 'package:get/get.dart';

class creditCardController extends GetxController {
  String selectedProvider = "MasterCard";
  void changeProvider(String s) {
    if (s == "MasterCard") {
      isVisa = false;
      selectedProvider = "Master Card";
      update();
    }
    if (s == "Visa") {
      isVisa = true;
      selectedProvider = "Visa";
      update();
    }
  }

  bool isVisa = false;

  String s = "XXXX - XXXX - XXXX -XXXX";
  void changenumber(String string) {
    if (string.isEmpty) {
      s = "XXXX - XXXX - XXXX -XXXX";
      update();
    }
    if (string.isNotEmpty) {
      List<String> list = string.split('');
      s = showNumber(list);
      update();
    }
  }

  String showNumber(List<String> list) {
    StringBuffer buffer = StringBuffer();
    if (list.length > 4 && list.length < 9) {
      list.insert(4, ' - ');
      for (String s in list) {
        buffer.write(s);
      }
      return buffer.toString();
    }
    if (list.length >= 8 && list.length < 12) {
      list.insert(4, ' - ');
      list.insert(9, ' - ');
      for (String s in list) {
        buffer.write(s);
      }
      return buffer.toString();
    }

    if (list.length >= 12) {
      list.insert(4, ' - ');
      list.insert(9, ' - ');
      list.insert(14, ' - ');
      for (String s in list) {
        buffer.write(s);
      }
      return buffer.toString();
    }
    for (String s in list) {
      buffer.write(s);
    }
    return buffer.toString();
  }
}
