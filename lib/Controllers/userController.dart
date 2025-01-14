import 'package:get/get.dart';
import 'package:mamamia_uniproject/main.dart';

class UserController extends GetxController {
  var firstName = ''.obs;
  var lastName = ''.obs;

  void updateFirstName() {
    firstName.value = userInfo!.getString('first_name')!;
    update();
  }

  void updateLastName() {
    lastName.value = userInfo!.getString('last_name')!;
    update();
  }
}
