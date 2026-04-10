import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceItem extends StatelessWidget {
  final String assetPath;
  final String label;

  const ServiceItem({super.key, required this.assetPath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        assetPath.endsWith('.svg')
            ? SvgPicture.asset(
          assetPath,
          width: 70,
          height: 70,
          fit: BoxFit.contain,
        )
            : Image.asset(
          assetPath,
          width: 44,
          height: 44,
          fit: BoxFit.contain,
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}