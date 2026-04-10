import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Widgets/ActionCard.dart';
import '../Widgets/CoinCards.dart';
import '../Widgets/ServiceItem.dart';
import '../colors/AppColors.dart';
import '../../data/Models/CoinModel.dart';
import '../cubits/app_cubit.dart';
import '../cubits/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D2733),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  color: const Color(0xFF1D2733),
                  padding: const EdgeInsets.only(bottom: 25),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    childAspectRatio: 0.9,
                    children: const [
                      ServiceItem(assetPath: "assets/images/deposit.svg", label: "Deposit"),
                      ServiceItem(assetPath: "assets/images/referral.svg", label: "Referral"),
                      ServiceItem(assetPath: "assets/images/gridtrading.svg", label: "Grid Trading"),
                      ServiceItem(assetPath: "assets/images/margin.svg", label: "Margin"),
                      ServiceItem(assetPath: "assets/images/launchpad.svg", label: "Launchpad"),
                      ServiceItem(assetPath: "assets/images/savings.svg", label: "Savings"),
                      ServiceItem(assetPath: "assets/images/liuidswap.svg", label: "Liquid Swap"),
                      ServiceItem(assetPath: "assets/images/more.svg", label: "More"),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const ActionCard(
                        title: "P2P Trading",
                        subtitle: "Bank Transfer, Paypal, Revolut...",
                        imagePath: "assets/images/rocket (1).png",
                      ),
                      const ActionCard(
                        title: "Credit/Debit Card",
                        subtitle: "Visa, Mastercard",
                        imagePath: "assets/images/card.png",
                      ),
                      _buildSectionTitle("Recent Coin"),
                      _buildCoinList(),
                      _buildSectionTitle("Top Coins"),
                      _buildCoinList(),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoinList() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (state.isHomeCoinsLoading) {
          return const SizedBox(
            height: 165,
            child: Center(child: CircularProgressIndicator(color: AppColors.grey)),
          );
        } else if (state.homeCoins.isEmpty) {
          return const Center(child: Text("No Data"));
        }

        final coins = state.homeCoins;

        return SizedBox(
          height: 165,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            itemCount: coins.length,
            itemBuilder: (context, index) {
              final coin = coins[index];
              return CoinCard(
                pair: "${coin.symbol.replaceAll('USDT', '')}/USDT",
                price: double.parse(coin.price).toStringAsFixed(2),
                change: "${coin.PriceChangePercent}%",
                isUp: !coin.PriceChangePercent.startsWith('-'),
                onTap: () {
                  context.push('/details', extra: coin);
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}