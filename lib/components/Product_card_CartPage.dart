import 'package:flutter/material.dart';
import 'package:mamamia_uniproject/main_page.dart';
// this is the product card in the cart page it have delete button to delete it

class ProjectProductCartCard extends StatelessWidget {
  final String imageAsset;
  final String productName;
  final String description;
  final double price;
  final Function mostlyDeleteButton;

  const ProjectProductCartCard({
    super.key,
    required this.imageAsset,
    required this.productName,
    required this.description,
    required this.price,
    required this.mostlyDeleteButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      image: AssetImage(imageAsset),
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
                      productName,
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Text(description),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        //! product price @cart
                        '$price \$',
                        style: TextStyle(
                            color: MainPage.orangeColor,
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
                          backgroundColor: MainPage.orangeColor,
                          padding: const EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () => mostlyDeleteButton(),
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
    );
  }
}
