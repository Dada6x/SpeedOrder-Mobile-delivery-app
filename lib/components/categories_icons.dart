import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model.dart';
import 'package:mamamia_uniproject/Screens/Categories_page.dart';

import 'package:mamamia_uniproject/main_page.dart';

class ProjectCategoriesIcons extends StatelessWidget {
  final IconData icon;
  final String categorie;
  const ProjectCategoriesIcons({
    super.key,
    required this.icon,
    required this.categorie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(CategoriesPage(
          Category: categorie, // u need an english lesson yahea
        ));
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Icon(
                    icon,
                    color: MainPage.orangeColor,
                    size: 30,
                  ),
                  Center(
                    child: Text(categorie),
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
    return MaterialButton(
      onPressed: () {
        Get.find<Model>().UrlLauncher(name);
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
              color: Colors.white,
              size: 40,
            )),
      ),
    );
  }
}
