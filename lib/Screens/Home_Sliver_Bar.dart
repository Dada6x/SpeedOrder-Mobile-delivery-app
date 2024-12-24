import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/Screens/home_page.dart';

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
            Get.find<HomePageProductController>().p1.homeCard!,
            Get.find<HomePageProductController>().p2.homeCard!,
            Get.find<HomePageProductController>().p3.homeCard!,
            Get.find<HomePageProductController>().p4.homeCard!,
          ]))
        ],
      ),
    );
  }
}
