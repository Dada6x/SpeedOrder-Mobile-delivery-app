import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model.dart';
import 'package:mamamia_uniproject/Controllers/credit_card_controller.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: creditCardController(),
        builder: (controller) => Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: Get.find<Model>().screenHeight(context) * 0.1),
                  child: Card(
                    elevation: 15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: Get.find<Model>().screenHeight(context) * 0.2,
                        width: Get.find<Model>().screenWidth(context) * 0.90,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'Ward Ekhtiar',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 20),
                                    child: SizedBox(
                                        height: 30,
                                        width: 60,
                                        child: Image.asset(Get.find<
                                                    creditCardController>()
                                                .isVisa
                                            ? "assets/images/visa.png"
                                            : "assets/images/mastercard.png")))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25, left: 20),
                              child: Row(
                                children: [
                                  SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Image.asset(
                                          "assets/images/chip.png")),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.contactless_outlined,
                                    size: 35,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  style: const TextStyle(fontSize: 20),
                                  controller.s,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
