import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:mamamia_uniproject/Screens/favorite_page.dart';
import 'package:mamamia_uniproject/Screens/profile_page.dart';
import 'package:mamamia_uniproject/Screens/cart_page.dart';
import 'package:mamamia_uniproject/Screens/Home_Sliver_Bar.dart';
import 'package:mamamia_uniproject/Screens/store_page.dart';

class MainPage extends StatefulWidget {
  //! its bad idea to put the colors static coz it wont change until the next time its runned
  // or make the changes apply the next time user open the app
  static Color orangeColor = const Color(0xFFEC6335);
  static Color blackColor = const Color(0xFF131313);
  static Color greyColor = const Color(0xFF191919);
  static Color darkgreyColor = const Color(0xFF131217);

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 2;

  List<Widget> screens = [
    //removed the search page from here cuz i think this the list used for navigation bar pages
    //search screen is in search_bar.dart;
    const StoresPage(),
    const CartPage(),
    const Test(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //! ########################### GET RID OF THEIS GIANT BTM NAVIGATION BAR U STUPID NIGGER  😠###########
        bottomNavigationBar: Directionality(
          textDirection: TextDirection.ltr,
          child: CurvedNavigationBar(
            height: 60,
            // buttonBackgroundColor: MainPage.greyColor
            color: Theme.of(context).colorScheme.secondary,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 250),
            index: index,
            onTap: (value) {
              // how to not use set state with the bottom navigation
              setState(() {
                index = value;
              });
            },
            items: [
              // toggle icons between selected and not selected
              // maybe if the light theme is so bright the colors needs to be switched
              Icon(
                index == 0
                    ? Icons.store
                    : Icons.store_outlined, //changed to store instead of search
                color: index == 0 ? MainPage.orangeColor : Colors.white,
                size: 30,
              ),
              Icon(
                index == 1 ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                color: index == 1 ? MainPage.orangeColor : Colors.white,
                size: 30,
              ),
              Icon(
                index == 2 ? Icons.home : Icons.home_outlined,
                color: index == 2 ? MainPage.orangeColor : Colors.white,
                size: 30,
              ),
              Icon(
                index == 3 ? Icons.favorite : Icons.favorite_border_outlined,
                color: index == 3 ? MainPage.orangeColor : Colors.white,
                size: 30,
              ),
              Icon(
                index == 4 ? Icons.person : Icons.person_outline,
                color: index == 4 ? MainPage.orangeColor : Colors.white,
                size: 30,
              ),
            ],
          ),
        ),
        body: screens[index]);
  }
}
