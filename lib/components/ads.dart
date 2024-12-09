import 'package:flutter/material.dart';
import 'package:mamamia_uniproject/main_page.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//! useable for the image but i dont have images yet
//the images will be static for the program the user never use them
// maybe  just the admin

Ad(Color color) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      height: 100,
    ),
  );
}
// the dots that moves under the ads 
Widget AdsIndicator(controller) {
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
                    Ad(MainPage.orangeColor), Ad(Colors.pink), Ad(Colors.teal),
                    Ad(Colors.blueGrey),
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
                    activeDotColor: MainPage.orangeColor,
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
