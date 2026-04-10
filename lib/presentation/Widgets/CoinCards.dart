import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/AppColors.dart';

class CoinCard extends StatelessWidget {
  final String pair;
  final String price;
  final String change;
  final bool isUp;

  const CoinCard({
    super.key,
    required this.pair,
    required this.price,
    required this.change,
    required this.isUp,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(price, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
              Icon(isUp ? Icons.currency_bitcoin : Icons.token, size: 18, color: Colors.orange),
            ],
          ),
          Text(pair, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 5),
          Text(change, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontSize: 12)),
          const Spacer(),
          Icon(Icons.show_chart, color: isUp ? Colors.green.withOpacity(0.5) : Colors.red.withOpacity(0.5), size: 40),
        ],
      ),
    ));
  }
}