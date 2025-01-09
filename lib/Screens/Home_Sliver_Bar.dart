import 'package:flutter/material.dart';
import 'package:mamamia_uniproject/Models/products.dart';
import 'package:mamamia_uniproject/Screens/home_page.dart';
import 'package:mamamia_uniproject/main.dart';

class HomeSliver extends StatelessWidget {
  const HomeSliver({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 500,
            centerTitle: true,
            collapsedHeight: 60,
            forceMaterialTransparency: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: HomeNeedToBeSlivered(),
            ),
          ),
          //! the Products List NOW its fixed
          SliverList(
              delegate: SliverChildListDelegate([
            Divider(
              height: 1,
              indent: screenWidth(context) * 0.4,
              endIndent: screenWidth(context) * 0.4,
              color: Theme.of(context).colorScheme.primary,
            ),
            const Productsgetter()
          ]))
        ],
      ),
    );
  }
}
