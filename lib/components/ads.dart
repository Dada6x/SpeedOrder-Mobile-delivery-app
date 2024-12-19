import 'package:flutter/material.dart';
import 'package:mamamia_uniproject/main_page.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//! useable for the image but i dont have images yet
//the images will be static for the program the user never use them
// maybe  just the admin

Ad(String adimageassets) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(adimageassets),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      height: 100,
    ),
  );
}

// the dots that moves under the ads
class AdsIndicator extends StatelessWidget {
  PageController controller;
  AdsIndicator({super.key, required this.controller});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 120,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  PageView(
                    controller: controller,
                    children: [
                      //! make the children takes String assets bruh
                      //! the ads should be images
                      Ad("assets/images/clothesPoster.jpg"),
                      Ad("assets/images/furniturePoster.jpg"),
                      Ad("assets/images/clothesPoster.jpg"),
                      Ad("assets/images/furniturePoster.jpg"),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 4,
                  effect: ExpandingDotsEffect(
                      activeDotColor: Theme.of(context).colorScheme.primary,
                      dotHeight: 10,
                      dotWidth: 10,
                      dotColor: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
