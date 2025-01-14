import 'package:flutter/material.dart';
PreferredSizeWidget NormalAppBar(String text) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    surfaceTintColor: Colors.transparent,
    forceMaterialTransparency: true,
    elevation: 0,
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 30),
      ),
    ),
  );
}
