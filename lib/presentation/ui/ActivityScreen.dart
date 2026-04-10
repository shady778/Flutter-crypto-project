import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../Widgets/ActivityRow.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D2733),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Activity",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 10),
          _activityMenu("Deposit", "assets/images/Bulk Icons.png"),
          _activityMenu("Withdrawals", "assets/images/Component 5.png"),
          _activityMenu("Buy Order", "assets/images/shopping-cart.png"),
          const SizedBox(height: 35),
          const Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          const ActivityRow(
            pair: "BTC/BUSD",
            amount: "0.49975/0.49975",
            price: "2652.00",
            status: "Filled",
            isFilled: true,
          ),
          const ActivityRow(
            pair: "ETH/BUSD",
            amount: "1.200/1.200",
            price: "3120.00",
            status: "Cancelled",
            isFilled: false,
          ),
          const ActivityRow(
            pair: "SOL/BUSD",
            amount: "10.0/10.0",
            price: "105.00",
            status: "Filled",
            isFilled: true,
          ),
        ],
      ),
    );
  }

  Widget _activityMenu(String title, String assetPath) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        assetPath,
        width: 66,
        height: 66,
        color: Colors.grey[400],
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
      onTap: () {},
    );
  }
}
