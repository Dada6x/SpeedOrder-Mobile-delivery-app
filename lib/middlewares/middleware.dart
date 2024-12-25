import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/main.dart';

class MiddlewareAuth extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (sharedPref!.getString("id") != null)
      return const RouteSettings(name: "/mainPage");
    return super.redirect(route);
  }
}
