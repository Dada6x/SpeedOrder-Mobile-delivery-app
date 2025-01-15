class ApiEndpoints {
  static const String RegisterBase = "http://127.0.0.1:8000/api/";
  static const String ApiBase = "http://127.0.0.1:8000/api/auth/";

  static String AddToCartAPI(String ProductID, String count) {
    String api = "${ApiBase}add_to_cart?token=  &product_id=$ProductID&count=$count";
    return api;
  }
}
