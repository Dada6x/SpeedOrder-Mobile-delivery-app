import 'package:flutter/material.dart';

class StoreAboutPage extends StatelessWidget {
  const StoreAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Asus"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: screenHeight / 3.2,
              child: Stack(
                children: [
                  StoreImage(
                    storeImage: "assets/images/rog.jpeg",
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Material(
                                color: Theme.of(context).colorScheme.secondary,
                                type: MaterialType.circle,
                                elevation: 1,
                                child: const CircleAvatar(
                                  radius: 55,
                                  backgroundImage:
                                      AssetImage("assets/images/asus.jpg"),
                                ),
                              ),
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 12, bottom: 20.0),
                                child: Text(
                                  "Electronics & Hardware Store ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Card(
              elevation: 2,
              child: ListTile(
                title: Text(
                  "About us:",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.primary),
                ),
                subtitle: const Text(
                  "f your assignment asks you to take a position or develop a claim about a subject, you may need to convey that position or claim in a thesis statement near the beginning of your draft. The assignment may not explicitly state that you need a thesis statement because your instructor may assume you will include one. When in doubt, ask your instructor if the assignment requires a thesis statement. When an assignment asks you to analyze, to interpret, to compare and contrast, to demonstrate cause and effect, or to take a stand on an issue, if your assignment asks you to take a position or develop a claim about a subject, you may need to convey that position or claim in a thesis statement near the beginning of your draft. The assignment may not explicitly state that you need a thesis statement because your instructor may assume you will include one. When in doubt, ask your instructor if the assignment requires a thesis statement. When an assignment asks you to analyze, to interpret, to compare and contrast, to demonstrate cause and effect, or to take a stand on an issue, ",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 7,
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  "Our Products:",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.asset(
                                  "assets/images/rog.jpeg",
                                  fit: BoxFit.cover,
                                )),
                            const Text("Rog")
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.asset(
                                  "assets/images/rog.jpeg",
                                  fit: BoxFit.cover,
                                )),
                            const Text("Rog")
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.asset(
                                  "assets/images/rog.jpeg",
                                  fit: BoxFit.cover,
                                )),
                            const Text("Rog")
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.asset(
                                  "assets/images/rog.jpeg",
                                  fit: BoxFit.cover,
                                )),
                            const Text("Rog")
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.asset(
                                  "assets/images/rog.jpeg",
                                  fit: BoxFit.cover,
                                )),
                            const Text("Rog")
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.asset(
                                  "assets/images/rog.jpeg",
                                  fit: BoxFit.cover,
                                )),
                            const Text("Rog")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class StoreImage extends StatelessWidget {
  const StoreImage({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.storeImage,
  });
  final String storeImage;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      height: screenHeight / 4,
      width: screenWidth,
      //! Background image icon
      storeImage,
      fit: BoxFit.cover,
    );
  }
}
