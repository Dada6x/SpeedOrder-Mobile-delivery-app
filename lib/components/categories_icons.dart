import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/Screens/Categories_page.dart';



// ignore: must_be_immutable
class ProjectCategoriesIcons extends StatelessWidget {
  final IconData icon;
  final String categorie;
  String? displayedCategory;
  ProjectCategoriesIcons({
    super.key,
    required this.icon,
    required this.categorie,
  }) {
    displayedCategory = "$categorie${" "}".tr;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(CategoriesPage(
          Category: categorie, // u need an english lesson yahea
        ));
      },
      child: Card(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.secondary,
            ),
            width: 70,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30,
                  ),
                  Center(
                    child: Text(displayedCategory!),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class ProjectCategoriesIconsWithoutLabel extends StatelessWidget {
  final IconData icon;
  final String name;
  const ProjectCategoriesIconsWithoutLabel({
    super.key,
    required this.icon,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<Model>().urlLauncher(name);
        print(name);
      },
      child: Card(
        elevation: 10,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.secondary,
            ),
            width: 70,
            height: 70,
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 40,
            )),
      ),
    );
  }
}
