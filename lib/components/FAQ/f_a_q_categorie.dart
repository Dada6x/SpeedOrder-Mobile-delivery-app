import 'package:flutter/material.dart';

class FAQcategorie extends StatelessWidget {
  const FAQcategorie({
    super.key,
    required this.categorie,
    required this.icon,
  });
  final String categorie;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF6EA7F2),
                  // maxRadius: 15,
                  radius: 14,
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Center(
                  child: Text(
                    categorie,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
