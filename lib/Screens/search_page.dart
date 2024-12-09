import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/components/search_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar('Search'.tr),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(child: ProjectSearchBar()),
        ],
      ),
    );
  }
}
