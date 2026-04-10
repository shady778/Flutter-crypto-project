class CoinModel {
  final String symbol;
  final String price;
  final String PriceChangePercent;

  const CoinModel({
    required this.price,
    required this.PriceChangePercent,
    required this.symbol,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      symbol: json['symbol']?.toString() ?? "",
      price: json['lastPrice']?.toString() ?? "0.0",
      PriceChangePercent: json['priceChangePercent']?.toString() ?? "0.0",
    );
  }

  @override
  List<Object?> get props => [symbol, price, PriceChangePercent];
}
