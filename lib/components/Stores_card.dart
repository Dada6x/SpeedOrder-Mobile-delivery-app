import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Screens/store_about_page.dart';

class Company {
  var id;
  String name;
  String location;
  String phoneNumber;
  Company(this.name, this.id, this.phoneNumber, this.location);
}

// ignore: must_be_immutable
class StoresCard extends StatelessWidget {
  var id;
  String location;
  String name;
  String phoneNumber;
  StoresCard(
      {super.key,
      required this.id,
      required this.name,
      required this.location,
      required this.phoneNumber});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            Company company = Company(name, id, phoneNumber, location);
            Get.to(StoreAboutPage(
              company: company,
            ));
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // the color of the card
                color: Theme.of(context).colorScheme.secondary),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: const Image(
                          //! the product image @cart
                          image: AssetImage("assets/images/Store.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //! product name @cart
                          name,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                        Row(children: [
                          Icon(
                            Icons.call_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(phoneNumber)
                        ]),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.primary,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
