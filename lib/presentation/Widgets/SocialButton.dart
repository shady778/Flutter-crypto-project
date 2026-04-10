import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String label;
  final String iconPath;

  const SocialButton({super.key, required this.label, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
            iconPath,
            height: 22,
            width: 22,

            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error, color: Colors.red, size: 22);
            }),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}