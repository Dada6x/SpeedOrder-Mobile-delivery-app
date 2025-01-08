import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Controllers/f_a_q_controller.dart';
import 'package:mamamia_uniproject/components/FAQ/question_tile.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/model/f_a_q_item.dart';

// ignore: must_be_immutable
class FAQCateogryPage extends StatelessWidget {
  final String category;
  List<FAQItem>? filteredlist;
  FAQCateogryPage({super.key, required this.category}) {
    filteredlist = Get.find<FAQController>()
        .QuestionList()
        .where(
            (element) => element.categorie.isCaseInsensitiveContains(category))
        .toList();
    print(category);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar(category),
      body: ListView(children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: filteredlist!.length,
            itemBuilder: (context, index) {
              return QuestionTile(FAQ: filteredlist![index]);
            }),
      ]),
    );
  }
}
