import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/Controllers/cart_controller.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';
import 'package:mamamia_uniproject/main.dart';

// this is the product card in the cart page it have delete button to delete it

class ProjectProductCartCard extends StatelessWidget {
  final Product
      product; //all the variables it required before are in the product so why not use it
  const ProjectProductCartCard({super.key, required this.product});

  get http => null;
  Future<void> deleteCartProduct(int id) async {
    String? token = await Get.find<Model>().getToken();
    final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/api/auth/delete_from_cart"),
        body: {"token": token, "id": id});
    // Get.find<CartController>().;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          // height: 150,
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
                        style: const TextStyle(fontSize: 25),
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
                            deleteCartProduct(product.id);
                          },
                          icon: const Icon(
                            Icons.delete_outline_outlined,
                            color: Colors.black,
                          )),
                      TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            Get.dialog(EditQuantityDialog(
                              p: product,
                            ));
                          },
                          child: SizedBox(
                            child: Text(
                              product.count.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
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

class EditQuantityDialog extends StatelessWidget {
  const EditQuantityDialog({super.key, required this.p});
  final Product p;

  get http => null;
  Future<void> EditProductCartCount(int id, int count) async {
    String? token = await Get.find<Model>().getToken();
    final response = await http
        .post(Uri.parse("http://127.0.0.1:8000/api/auth/edit_cart"), body: {
      "token": token,
      "id": id,
      "count": count,
    });
  }

  @override
  Widget build(BuildContext context) {
    int chosenCount = p.count;

    return Center(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          width: screenWidth(context) * 0.8,
          height: screenWidth(context) * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Choose quantity".tr,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        if (chosenCount > 1) {
                          chosenCount = chosenCount - 1;
                        }
                      },
                      icon: Icon(
                        Icons.minimize_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      )),
                  Text(
                    chosenCount.toString(),
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        chosenCount = chosenCount + 1;
                      },
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).colorScheme.secondary,
                      ))
                ],
              ),
              TextButton(
                  onPressed: () {
                    p.count = chosenCount;
                    EditProductCartCount(p.id, p.count);
                    Get.back();
                  },
                  child: const Text(
                    "Submit",
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
