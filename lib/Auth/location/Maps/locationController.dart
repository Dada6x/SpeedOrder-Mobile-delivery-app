import 'package:get/get.dart';

class LocationController extends GetxController {
  var selectedAddress = "".obs;

  // Method to update the address
  void updateLocation(String supaddress) {
    selectedAddress.value = supaddress;
  }

  // Method to fetch the current location (optional utility)
  String getCurrentLocation() {
    return selectedAddress.value;
  }
}
