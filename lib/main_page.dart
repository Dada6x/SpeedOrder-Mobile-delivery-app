import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/Screens/favorite_page.dart';
import 'package:mamamia_uniproject/Screens/notifications_Drawer.dart';
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

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 2;

  List<Widget> screens = [
    //removed the search page from here cuz i think this the list used for navigation bar pages
    //search screen is in search_bar.dart;
    //yahea: Good Job !!
    const StoresPage(),
    const CartPage(),
    const HomeSliver(), // this need to take the string ⟶ then HomeNeedToBeSlivered(), // needs to take the string as well ⟶ the location
    const FavoritePage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    Get.find<Model>().profileRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          key: MainPage.scaffoldKey,
          //! notifications drawer
          endDrawer: const Directionality(
            textDirection: TextDirection.ltr,
            child: Drawer(
              child: SafeArea(
                child: NotificationsDrawer(),
              ),
            ),
          ),
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
                setState(() {
                  index = value;
                });
              },
              items: [
                // toggle icons between selected and not selected
                // maybe if the light theme is so bright the colors needs to be switched
                index == 0
                    ? Icon(
                        size: 30,
                        Icons.store,
                        color: Theme.of(context).colorScheme.primary)
                    : const Icon(
                        size: 30,
                        Icons.store_outlined,
                      ),
                index == 1
                    ? Icon(
                        size: 30,
                        Icons.shopping_cart,
                        color: Theme.of(context).colorScheme.primary)
                    : const Icon(
                        size: 30,
                        Icons.shopping_cart_outlined,
                      ),
                index == 2
                    ? Icon(
                        size: 30,
                        Icons.home,
                        color: Theme.of(context).colorScheme.primary)
                    : const Icon(
                        size: 30,
                        Icons.home_outlined,
                      ),
                index == 3
                    ? Icon(
                        size: 30,
                        Icons.favorite,
                        color: Theme.of(context).colorScheme.primary)
                    : const Icon(
                        size: 30,
                        Icons.favorite_outline,
                      ),
                index == 4
                    ? Icon(Icons.person,
                        size: 30, color: Theme.of(context).colorScheme.primary)
                    : const Icon(
                        Icons.person_2_outlined,
                        size: 30,
                      ),
              ],
            ),
          ),
          body: screens[index]),
    );
  }
}
