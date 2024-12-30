import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mamamia_uniproject/Controllers/f_a_q_controller.dart';
import 'package:mamamia_uniproject/components/FAQ/f_a_q_page_categorie.dart';
import 'package:mamamia_uniproject/components/FAQ/f_a_q_page_header.dart';
import 'package:mamamia_uniproject/components/FAQ/question_tile.dart';
import 'package:mamamia_uniproject/model/f_a_q_item.dart';

class FAQPage extends StatelessWidget {
  FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<FAQItem> faqItems = Get.find<FAQController>().QuestionList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ"),
      ),
      body: ListView(
        children: [
          const FAQPageHeader(header: "Categories"),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: (144 / 100),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: const [
              FAQPageCategorie(
                category: "Account",
                icon: Icons.person,
              ),
              FAQPageCategorie(
                category: "Privacy Policy",
                icon: Icons.security,
              ),
              FAQPageCategorie(
                category: "Payment",
                icon: Icons.sticky_note_2,
              ),
              FAQPageCategorie(
                category: "Pateron",
                icon: Icons.propane,
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const FAQPageHeader(header: "Recently Answered Questions"),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: faqItems.length,
            itemBuilder: (context, index) {
              return QuestionTile(FAQ: faqItems[index]);
            },
          )
        ],
      ),
    );
  }
}
