import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Screens/profile_screens/FAQ/question_page.dart';
import 'package:mamamia_uniproject/model/f_a_q_item.dart';

class QuestionTile extends StatelessWidget {
  const QuestionTile({super.key, required this.FAQ});
  final FAQItem FAQ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Card(
        margin: const EdgeInsets.only(top: 10),
        elevation: 0,
        child: ListTile(
          onTap: () {
            Get.to(QuestionPage(FAQ: FAQ));
          },
          title: Text(
            FAQ.question,
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
