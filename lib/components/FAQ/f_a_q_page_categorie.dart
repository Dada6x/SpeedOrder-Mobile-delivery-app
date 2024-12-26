import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Screens/FAQ/categories_page.dart';

class FAQPageCategorie extends StatelessWidget {
  const FAQPageCategorie({
    super.key,
    required this.categorie,
    required this.icon,
  });
  final String categorie;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(FAQCateogriePage(categorie: categorie));
      },
      child: Card(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFF6EA7F2),
                    // maxRadius: 15,
                    radius: 14,
                    child: Icon(
                      icon,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Center(
                    child: Text(
                      categorie,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
