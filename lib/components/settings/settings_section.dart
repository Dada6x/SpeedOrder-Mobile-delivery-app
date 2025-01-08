import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  const SettingsSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0, top: 24),
      child: Text(
        title.tr,
        style: const TextStyle(fontSize: 20, color: Colors.black45),
      ),
    );
  }
}
