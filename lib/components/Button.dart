import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/main_page.dart';

// this is button that takes string and width and function
class ProjectButton extends StatelessWidget {
  final String text;
  final double width;
  final Function? function;

  const ProjectButton({
    super.key,
    required this.text,
    required this.width,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: MainPage.orangeColor,
          foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
          fixedSize: Size(width, 10)),
      onPressed: () {
        function!();
      },
      child: Text(text),
    );
  }
}
