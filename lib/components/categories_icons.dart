import 'package:flutter/material.dart';

import 'package:mamamia_uniproject/main_page.dart';

class ProjectCategoriesIcons extends StatelessWidget {
  final IconData icon;
  final String categorie;
  const ProjectCategoriesIcons(
      {super.key, required this.icon, required this.categorie});

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
    
  }
}
