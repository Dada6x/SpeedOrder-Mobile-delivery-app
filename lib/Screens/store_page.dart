import 'package:flutter/material.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';

class StoresPage extends StatelessWidget {
  const StoresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar("Stores"),
    );
  }
}
