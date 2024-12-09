import 'package:flutter/material.dart';

class Themes {
  final ThemeData lightMode = ThemeData(
      colorScheme: const ColorScheme.light(
    surface: Colors.white,
    brightness: Brightness.light,
    primary: Color(0xFFEC6335),
    secondary: Color.fromARGB(255, 230, 228, 228),
  ));

  final ThemeData darkMode = ThemeData(
      colorScheme: const ColorScheme.dark(
    surface: Color(0xFF131313),
    brightness: Brightness.dark,
    primary: Color(0xFFEC6335),
    secondary: Color(0xFF191919),
  ));
}
//! make something so 