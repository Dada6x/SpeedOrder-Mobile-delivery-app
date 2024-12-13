import 'package:flutter/material.dart';
import 'package:mamamia_uniproject/Screens/home_page.dart';
import 'package:mamamia_uniproject/components/Product_card_HomePage.dart';

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
            const ProjectProductCartCardHome(
              imageAsset: 'assets/images/weekend.png',
              productName: 'the weekend  ',
              description: 'the arabic weekend limited edition',
              price: 57.53,
              categoryIcon: Icons.fastfood_outlined,
            ),
            const ProjectProductCartCardHome(
              imageAsset: 'assets/images/dummyData/bag1.jpg',
              productName: 'Guuci ',
              description: 'women bag',
              price: 92.53,
              categoryIcon: Icons.woman_rounded,
            ),
            const ProjectProductCartCardHome(
              imageAsset: 'assets/images/dummyData/rolex.jpg',
              productName: 'Rolex ',
              description: 'descritption',
              price: 83.53,
              categoryIcon: Icons.child_care_outlined,
            ),
            const ProjectProductCartCardHome(
              imageAsset: 'assets/images/dummyData/perfume.jpg',
              productName: 'jacket ',
              description: 'descritption',
              price: 29.53,
              categoryIcon: Icons.card_giftcard_outlined,
            ),
            const ProjectProductCartCardHome(
              imageAsset: 'assets/images/dummyData/shoes.jpg',
              productName: 'Lebrn James ',
              description: '',
              price: 82.53,
              categoryIcon: Icons.food_bank_outlined,
            ),
            const ProjectProductCartCardHome(
              imageAsset: '',
              productName: 'Guuci ',
              description: 'descritption',
              price: 80.53,
              categoryIcon: Icons.food_bank_outlined,
            ),
            const ProjectProductCartCardHome(
              imageAsset: 'assets/images/dummyData/watch.jpg',
              productName: 'watch ',
              description: 'ddd',
              price: 8.53,
              categoryIcon: Icons.food_bank_outlined,
            ),
          ]))
        ],
      ),
    );
  }
}
