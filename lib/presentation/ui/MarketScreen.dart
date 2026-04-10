import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../Widgets/CoinTile.dart';
import '../cubits/app_cubit.dart';
import '../cubits/app_state.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      context.read<AppCubit>().updateMarketSearchQuery(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFF1D2733),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 10),
              child: Text("Market",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search coins...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFF2B394A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            TabBar(
              isScrollable: true,
              indicatorColor: const Color(0xFF5CE1AD),
              labelColor: const Color(0xFF5CE1AD),
              unselectedLabelColor: Colors.grey,
              onTap: (index) {
                context.read<AppCubit>().updateMarketFilter(index);
              },
              tabs: const [
                Tab(text: "All"),
                Tab(text: "Gainer"),
                Tab(text: "Loser"),
                Tab(text: "Favorites"),
              ],
            ),
            Expanded(
              child: BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  if (state.isMarketCoinsLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: Color(0xFF5CE1AD)));
                  }

                  // 1. Filter by Search Query
                  var filteredCoins = state.marketCoins.where((coin) {
                    return coin.symbol
                        .toLowerCase()
                        .contains(state.marketSearchQuery.toLowerCase());
                  }).toList();

                  // 2. Filter/Sort by Tab Index
                  switch (state.marketFilterIndex) {
                    case 1: // Gainer: Change > 0, sorted desc
                      filteredCoins = filteredCoins.where((c) {
                        final val = double.tryParse(c.PriceChangePercent) ?? 0.0;
                        return val > 0;
                      }).toList();
                      filteredCoins.sort((a, b) {
                        final valA =
                            double.tryParse(a.PriceChangePercent) ?? 0.0;
                        final valB =
                            double.tryParse(b.PriceChangePercent) ?? 0.0;
                        return valB.compareTo(valA);
                      });
                      break;
                    case 2: // Loser: Change < 0, sorted asc
                      filteredCoins = filteredCoins.where((c) {
                        final val = double.tryParse(c.PriceChangePercent) ?? 0.0;
                        return val < 0;
                      }).toList();
                      filteredCoins.sort((a, b) {
                        final valA =
                            double.tryParse(a.PriceChangePercent) ?? 0.0;
                        final valB =
                            double.tryParse(b.PriceChangePercent) ?? 0.0;
                        return valA.compareTo(valB);
                      });
                      break;
                    case 3: // Favorites
                      filteredCoins = filteredCoins.where((c) {
                        return state.favoriteCoins
                            .any((fav) => fav.symbol == c.symbol);
                      }).toList();
                      break;
                    default: // All
                      break;
                  }

                  if (filteredCoins.isEmpty) {
                    return const Center(
                        child: Text("No data found.",
                            style: TextStyle(color: Colors.grey)));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    itemCount: filteredCoins.length,
                    itemBuilder: (context, index) {
                      final coin = filteredCoins[index];
                      final isFavorite = state.favoriteCoins
                          .any((c) => c.symbol == coin.symbol);
                      final val =
                          double.tryParse(coin.PriceChangePercent) ?? 0.0;
                      final isUp = val >= 0;

                      return CoinTile(
                        iconPath: "assets/images/Crypto Logos.png",
                        name: coin.symbol,
                        symbol: coin.symbol,
                        price: coin.price,
                        change: "${coin.PriceChangePercent}%",
                        isUp: isUp,
                        isFavorite: isFavorite,
                        onFavoriteToggle: () {
                          context.read<AppCubit>().toggleFavorite(coin);
                        },
                        onTap: () {
                          context.push('/details', extra: coin);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}