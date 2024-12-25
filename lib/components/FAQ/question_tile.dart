import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Screens/profile_page.dart';

class QuestionTile extends StatelessWidget {
  const QuestionTile({super.key, required this.question});
  final String question;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Card(
        margin: const EdgeInsets.only(top: 10),
        elevation: 0,
        child: ListTile(
          onTap: () {
            Get.replace(const ProfilePage());
          },
          title: const Text(
            "what do you think of our service so far?",
            style: TextStyle(color: Colors.black54),
          ),
          tileColor: const Color(0xffEBEFF6),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          trailing: const Icon(Icons.arrow_forward_rounded),
          iconColor: Colors.black45,
        ),
      ),
    );
  }
}


 // ? Wanted to do a search bar but unnecessary.
          // Container(
          //   padding:
          //       const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
          //   width: screenWidth,
          //   child: const Column(
          //     children: [
          //       SizedBox(
          //         height: 20,
          //       ),
          //       Text(
          //         "Frequently asked questions",
          //         style: const TextStyle(color: Colors.black, fontSize: 18),
          //       ),
          //       SizedBox(height: 10),
          //       SearchBar(
          //           shape: WidgetStatePropertyAll(
          //             RoundedRectangleBorder(
          //               borderRadius: BorderRadius.all(Radius.circular(5)),
          //             ),
          //           ),
          //           backgroundColor: WidgetStatePropertyAll(Color(0xffEBEFF6)),
          //           leading: Icon(
          //             Icons.search,
          //             color: Colors.black45,
          //           ),
          //           hintText: "Looking for something specific?",
          //           hintStyle: WidgetStatePropertyAll(
          //               TextStyle(color: Colors.black54)))
          //     ],
          //   ),
          //   // color: Theme.of(context).primaryColor,
          // ),