import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mamamia_uniproject/Controllers/f_a_q_cotroller.dart';
import 'package:mamamia_uniproject/components/FAQ/question_tile.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/model/f_a_q_item.dart';

// ignore: must_be_immutable
class FAQCateogriePage extends StatelessWidget {
  final String categorie;
  List<FAQItem>? filteredlist;
  FAQCateogriePage({super.key, required this.categorie}) {
    filteredlist = Get.find<FaqCotroller>()
        .QuestionList()
        .where(
            (element) => element.categorie.isCaseInsensitiveContains(categorie))
        .toList();
    print(categorie);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar(categorie),
      body: ListView(children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: filteredlist!.length,
            itemBuilder: (context, index) {
              return QuestionTile(FAQ: filteredlist![index]);
            }),
      ]),
    );
  }
}
