import 'package:flutter/material.dart';

class ActivityRow extends StatelessWidget {
  final String pair;
  final String amount;
  final String price;
  final String status;
  final bool isFilled;

  const ActivityRow({
    super.key,
    required this.pair,
    required this.amount,
    required this.price,
    required this.status,
    required this.isFilled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: isFilled ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
            child: Text(
              isFilled ? "L/B" : "L/S",
              style: TextStyle(fontSize: 15, color: isFilled ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pair, style: const TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold)),
                Text("Amount: $amount", style: const TextStyle(color: Colors.grey, fontSize: 15)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                status,
                style: TextStyle(color: isFilled ? const Color(0xFF5CE1AD) : Colors.redAccent, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(price, style: const TextStyle(color: Colors.white, fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }
}