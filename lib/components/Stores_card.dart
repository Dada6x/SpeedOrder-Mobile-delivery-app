import 'package:flutter/material.dart';

class StoresCard extends StatelessWidget {
  const StoresCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(10),
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
                      borderRadius: BorderRadius.circular(45),
                      child: Image(
                        //! the product image @cart
                        image: AssetImage("assets/images/weekend.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //! product name @cart
                        "Asus",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                      Text("Electronics & Hardware Stores"),
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
    );
  }
}
