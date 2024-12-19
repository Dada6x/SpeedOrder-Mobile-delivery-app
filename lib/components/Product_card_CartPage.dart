import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/cart_controller.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';
import 'package:mamamia_uniproject/main_page.dart';

// this is the product card in the cart page it have delete button to delete it

class ProjectProductCartCard extends StatelessWidget {
  final Product
      product; //all the variables it required before are in the product so why not use it
  const ProjectProductCartCard({super.key, required this.product});

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
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        //! the product image @cart
                        image: AssetImage(product.imageLink),
                        fit: BoxFit.cover,
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
                        product.name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      Text(product.description),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          //! product price @cart
                          '${product.price} \$',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            Get.find<CartController>().removeFromCart(product);
                          },
                          icon: const Icon(
                            Icons.delete_outline_outlined,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
