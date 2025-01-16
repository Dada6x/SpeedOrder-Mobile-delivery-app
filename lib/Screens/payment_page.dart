import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/Controllers/cart_controller.dart';
import 'package:mamamia_uniproject/Controllers/credit_card_controller.dart';
import 'package:mamamia_uniproject/Controllers/orders_controller.dart';
import 'package:mamamia_uniproject/components/credit_card.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/main.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});

  Future<void> ConfirmPurchase(String card_password, String card_number) async {
    String? token = await Get.find<Model>().getToken();
    final response = await http.post(
        Uri.parse("http://192.168.1.110:8000/api/auth/add_to_confirm"),
        body: {
          "card_password": card_password,
          "token": token,
          "card_number": card_number,
        });
    if (response.statusCode == 200) {
      Get.snackbar("order is set for delievery",
          "Thank you for shopping at SpeedOrder <3");
    }
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String cardPassword = "";
    String cardNumber = "";
    return Scaffold(
      appBar: NormalAppBar("Enter Card info".tr),
      body: GetBuilder(
          init: creditCardController(),
          builder: (controller) => SingleChildScrollView(
                child: Column(
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
                          cardNumber = value;
                        },
                        decoration: InputDecoration(
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: const Icon(
                              Icons.credit_card,
                              color: Colors.grey,
                            ),
                            hintText: "XXXX - XXXX - XXXX -XXXX",
                            labelText: "Card Number".tr),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 20, right: 20),
                      child: TextField(
                        onChanged: (value) {
                          cardPassword = value;
                        },
                        decoration: InputDecoration(
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon:
                                const Icon(Icons.key, color: Colors.grey),
                            labelText: "Password".tr,
                            hintText: "Password".tr),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary),
                        onPressed: () async {
                          ConfirmPurchase(cardPassword, cardNumber);
                          Get.back();
                          Future.delayed(const Duration(seconds: 1), () {});
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: screenWidth(context) * 0.20),
                          child: Text(
                            "Confirm Purchase".tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        )),
                  ],
                ),
              )),
    );
  }
}
