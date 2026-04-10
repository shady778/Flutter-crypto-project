import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/AppColors.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const ActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, width: 70, height: 70),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold,color: AppColors.black, fontSize: 20)),
                Text(subtitle, style: const TextStyle(color: AppColors.grey, fontSize: 16)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 20, color: AppColors.grey),
        ],
      ),
    );
  }
}