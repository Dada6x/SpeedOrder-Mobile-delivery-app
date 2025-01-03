import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:mamamia_uniproject/components/categories_icons.dart';

class Oursocials extends StatelessWidget {
  const Oursocials({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ProjectCategoriesIconsWithoutLabel(
          icon: FontAwesomeIcons.facebook,
          name: "facebook",
        ),
        ProjectCategoriesIconsWithoutLabel(
          icon: FontAwesomeIcons.instagram,
          name: "instagram",
        ),
        ProjectCategoriesIconsWithoutLabel(
          icon: FontAwesomeIcons.twitter,
          name: "twitter",
        ),
      ],
    );
  }
}
