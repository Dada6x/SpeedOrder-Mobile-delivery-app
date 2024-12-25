import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/components/FAQ/f_a_q_categorie.dart';
import 'package:mamamia_uniproject/components/FAQ/f_a_q_header.dart';
import 'package:mamamia_uniproject/components/FAQ/question_tile.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ"),
      ),
      body: ListView(
        children: [
          const FAQheader(header: "Categories"),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: (144 / 100),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: const [
              FAQcategorie(
                categorie: "Account",
                icon: Icons.person,
              ),
              FAQcategorie(
                categorie: "Privacy Policy",
                icon: Icons.security,
              ),
              FAQcategorie(
                categorie: "Payment",
                icon: Icons.sticky_note_2,
              ),
              FAQcategorie(
                categorie: "Pateron",
                icon: Icons.propane,
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const FAQheader(header: "Recently Answered Questions"),
          const QuestionTile(question: "hello"),
          const QuestionTile(question: "hello"),
          const QuestionTile(question: "hello"),
          const QuestionTile(question: "hello"),
          const QuestionTile(question: "hello"),
        ],
      ),
    );
  }
}
