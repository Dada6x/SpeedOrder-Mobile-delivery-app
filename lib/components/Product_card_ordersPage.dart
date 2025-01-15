import 'package:flutter/material.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';

class ProjectProductOrdersCard extends StatelessWidget {
  // List<Product> products;
  Product product = Product(1, "Coffee", 100, "Helps you break ankels",
      "assets/images/product.png", "Store", 1);
  ProjectProductOrdersCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name),
                        Text(product.price.toString() + "\$"),
                      ],
                    ),
                    trailing: Text(
                      product.count.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
