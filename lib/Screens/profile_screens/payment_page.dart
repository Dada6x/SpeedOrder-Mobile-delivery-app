import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model.dart';
import 'package:mamamia_uniproject/Controllers/cart_controller.dart';
import 'package:mamamia_uniproject/Controllers/credit_card_controller.dart';
import 'package:mamamia_uniproject/components/credit_card.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/main_page.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar("Enter Your Card info".tr),
      body: GetBuilder(
          init: creditCardController(),
          builder: (controller) => Column(
                children: [
                  const CreditCard(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Choose a Provider:".tr,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Card(
                          elevation: 10,
                          child: PopupMenuButton(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Text(
                                      Get.find<creditCardController>()
                                          .selectedProvider,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Icon(
                                        Icons.arrow_drop_down_circle_outlined)
                                  ],
                                ),
                              ),
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                        child: const Text("MasterCard"),
                                        onTap: () {
                                          Get.find<creditCardController>()
                                              .changeProvider("MasterCard");
                                        }),
                                    PopupMenuItem(
                                        child: const Text("Visa"),
                                        onTap: () {
                                          Get.find<creditCardController>()
                                              .changeProvider("Visa");
                                        }),
                                  ]),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 16,
                      controller: textEditingController,
                      onChanged: (value) {
                        Get.find<creditCardController>().changenumber(value);
                      },
                      decoration: InputDecoration(
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: const Icon(Icons.credit_card),
                          hintText: "XXXX - XXXX - XXXX -XXXX",
                          labelText: "Card Number".tr),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: const Icon(Icons.key),
                          labelText: "Password".tr,
                          hintText: "Password".tr),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: MainPage.orangeColor),
                      onPressed: () {
                        Get.find<CartController>().removeAllFromCart();
                        Get.back();
                        Future.delayed(const Duration(seconds: 1), () {
                          Get.snackbar("Success!".tr,
                              "Congartulations on Your Purchase,Enjoy!".tr);
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal:
                                Get.find<Model>().screenWidth(context) * 0.20),
                        child: Text(
                          "Confirm Purchase".tr,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      )),
                ],
              )),
    );
  }
}
