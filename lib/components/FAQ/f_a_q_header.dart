import 'package:flutter/material.dart';

class FAQheader extends StatelessWidget {
  const FAQheader({super.key, required this.header});
  final String header;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          header,
          style: const TextStyle(
              color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
