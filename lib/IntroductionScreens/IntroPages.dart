import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mamamia_uniproject/Auth/Login_Page.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPages extends StatefulWidget {
  const IntroPages({super.key});

  @override
  State<IntroPages> createState() => _IntroPagesState();
}

class _IntroPagesState extends State<IntroPages> {
  final _pageController = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          onPageChanged: (pageIndex) {
            setState(() {
              onLastPage = (pageIndex == 2);
              // if the last page is the current page (using onPageChanged) return true
            });
          },
          controller: _pageController,
          children: [
            Intro(
                LottieAsset: 'assets/animations/Deleviery.json',
                Description: 'Fast and Reliable Deliveries'),
            Intro(
                LottieAsset: 'assets/animations/sale.json',
                Description: 'Unbeatable Prices Guaranteed'),
            Intro(
                LottieAsset: 'assets/animations/deleciryguy.json',
                Description: 'Start Ordering Now !!'),
          ],
        ),
        Container(
          alignment: const Alignment(0, 0.89),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  _pageController.jumpToPage(3);
                },
                child: const Text('Skip'),
              ), //! the page indicator
              SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  activeDotColor: Theme.of(context).colorScheme.primary,
                  dotColor: Colors.grey.shade300,
                ),
              ),
              //ternary operator
              onLastPage
                  ? GestureDetector(
                      onTap: () {
                        Get.off(const LoginPage());
                      },
                      child: const Text('Done'),
                    )
                  : GestureDetector(
                      onTap: () {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      },
                      child: const Text('Next'),
                    )
            ],
          ),
        )
      ],
    ));
  }
}

Widget Intro({required String LottieAsset, required String Description}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      const SizedBox(
        height: 35,
      ),
      Expanded(flex: 2, child: Center(child: Lottie.asset(LottieAsset))),
      Expanded(
        child: Center(
          child: Text(
            Description,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      )
    ],
  );
}
