import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Widgets/CoinTile.dart';
import '../cubits/app_cubit.dart';
import '../cubits/app_state.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D2733),
      body: SafeArea(
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final favSymbols = state.favoriteCoins.map((e) => e.symbol).toSet();
            final liveFavs = state.marketCoins.where((c) => favSymbols.contains(c.symbol)).toList();

            double totalBalance = 0.0;
            for (var c in liveFavs) {
              totalBalance += double.tryParse(c.price) ?? 0.0;
            }

            final isLoading = state.isFavoritesLoading || state.isMarketCoinsLoading;

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text("Current Balance", style: TextStyle(color: Colors.grey, fontSize: 14)),
                const SizedBox(height: 8),
                Text("\$${totalBalance.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 30),
                Row(
                  children: [
                    _actionBtn("Deposit", const Color(0xFF5CE1AD), Colors.black),
                    const SizedBox(width: 12),
                    _actionBtn("Withdraw", Colors.grey.withOpacity(0.2), Colors.white),
                    const SizedBox(width: 12),
                    _actionBtn("Transfer", Colors.grey.withOpacity(0.2), Colors.white),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Assets",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      onPressed: () {
                        context.read<AppCubit>().loadAllData();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                if (isLoading)
                  const Center(
                      child: Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(color: Color(0xFF5CE1AD))))
                else if (liveFavs.isEmpty)
                  const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("No favorite coins found.", style: TextStyle(color: Colors.grey)))
                else
                  ...liveFavs.map((coin) {
                    final val = double.tryParse(coin.PriceChangePercent) ?? 0.0;
                    return CoinTile(
                      iconPath: "assets/images/Crypto Logos.png",
                      name: coin.symbol,
                      symbol: coin.symbol,
                      price: coin.price,
                      change: "${coin.PriceChangePercent}%",
                      isUp: val >= 0,
                    );
                  }),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _actionBtn(String label, Color bg, Color text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
        child: Center(
            child:
                Text(label, style: TextStyle(color: text, fontWeight: FontWeight.bold, fontSize: 13))),
      ),
    );
  }
}