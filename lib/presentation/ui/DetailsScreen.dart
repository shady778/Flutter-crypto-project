import 'package:flutter/material.dart';
import '../../data/Models/CoinModel.dart';

class DetailsScreen extends StatelessWidget {
  final CoinModel coin;

  const DetailsScreen({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final val = double.tryParse(coin.PriceChangePercent) ?? 0.0;
    final isUp = val >= 0;

    return Scaffold(
      backgroundColor: const Color(0xFF1D2733),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D2733),
        elevation: 0,
        title: Text("${coin.symbol} Details", style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF28333F),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                   Image.asset(
                    "assets/images/Crypto Logos.png", // Using existing placeholder
                    width: 64,
                    height: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    coin.symbol,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${coin.price}",
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isUp ? const Color(0xFF5CE1AD).withOpacity(0.1) : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${coin.PriceChangePercent}%",
                      style: TextStyle(
                        color: isUp ? const Color(0xFF5CE1AD) : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Placeholder for Chart or additional info
            _buildInfoRow("Market Cap", "\$1.2T"),
            _buildInfoRow("24h Volume", "\$45.8B"),
            _buildInfoRow("Circulating Supply", "19.5M ${coin.symbol}"),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5CE1AD),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text(
                  "Buy Now",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 16)),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
