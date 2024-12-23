import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/Home_Page_controller.dart';
import 'package:mamamia_uniproject/Screens/home_page.dart';

class Test extends StatelessWidget {
  const Test({super.key});
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

            /* const ProjectProductCartCardHome(
              imageAsset: 'assets/images/weekend.png',
              productName: 'the weekend  ',
              description: 'the arabic weekend limited edition',
              price: 57.53,
              category: "food",
            ),
            const ProjectProductCartCardHome(
              imageAsset: '',
              productName: 'shoes ',
              description: 'descritption',
              price: 92.53,
              category: "clothes",
            ),
            const ProjectProductCartCardHome(
              imageAsset: '',
              productName: 'bruh ',
              description: 'descritption',
              price: 83.53,
              category: "clothes",
            ),
            const ProjectProductCartCardHome(
              imageAsset: '',
              productName: 'jacket ',
              description: 'descritption',
              price: 29.53,
              category: "clothes",
            ),
            const ProjectProductCartCardHome(
              imageAsset: '',
              productName: 'صرماية ',
              description: 'descritption',
              price: 82.53,
              category: "devices",
            ),
            const ProjectProductCartCardHome(
              imageAsset: '',
              productName: 'Guuci ',
              description: 'descritption',
              price: 80.53,
              category: "clothes",
            ),
            const ProjectProductCartCardHome(
              imageAsset: '',
              productName: 'Guuci ',
              description: 'descritption',
              price: 8.53,
              category: "clothes",
            ),*/
          ]))
        ],
      ),
    );
  }
}
