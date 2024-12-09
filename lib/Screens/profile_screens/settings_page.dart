import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
// location
// themes
// idk :D
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar("Settings".tr),
      body: const Center(
        child: Text('this is the Settings page 0 '),
      ),
    );
  }
}
