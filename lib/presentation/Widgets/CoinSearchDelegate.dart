import 'package:flutter/material.dart';
import '../../data/Models/CoinModel.dart';
import 'CoinTile.dart';
import 'package:go_router/go_router.dart';

class CoinSearchDelegate extends SearchDelegate<CoinModel?> {
  final List<CoinModel> coins;

  CoinSearchDelegate(this.coins);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1D2733),
        elevation: 0,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white),
      ),
      hintColor: Colors.grey,
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.white),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = coins.where((coin) {
      return coin.symbol.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return _buildList(results, context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = coins.where((coin) {
      return coin.symbol.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return _buildList(results, context);
  }

  Widget _buildList(List<CoinModel> results, BuildContext context) {
    return Container(
      color: const Color(0xFF1D2733),
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final coin = results[index];
          return CoinTile(
            iconPath: "assets/images/Crypto Logos.png",
            name: coin.symbol,
            symbol: coin.symbol,
            price: coin.price,
            change: "${coin.PriceChangePercent}%",
            isUp: (double.tryParse(coin.PriceChangePercent) ?? 0.0) >= 0,
            isFavorite: false, // Not handling favorite in search menu for simplicity
            onFavoriteToggle: () {},
            onTap: () {
              context.push('/details', extra: coin);
              close(context, coin);
            },
          );
        },
      ),
    );
  }
}
