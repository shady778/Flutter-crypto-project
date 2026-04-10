import 'package:first_flutter_project/data/DataSource/LocalDataSource/LocalDataSource.dart';
import 'package:first_flutter_project/data/DataSource/RemoteDatasource/RemoteDataSource.dart';
import 'package:first_flutter_project/data/Models/CoinModel.dart';

class AppRepo {
  final LocalDataSource _localDS;
  final RemoteDataSource _remoteDS;

  AppRepo(this._localDS, this._remoteDS);

  Future<bool> signup(String name, String email, String password) async {
    try {
      final id = await _localDS.registerUser({
        'name': name,
        'email': email,
        'password': password,
      });
      return id > 0;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final user = await _localDS.loginUser(email, password);
    return user != null;
  }

  bool checkUserLoggedIn() {
    return _localDS.hasSession();
  }

  Future<void> logout() async {
    await _localDS.clearSession();
  }

  Future<List<CoinModel>> getHomeCoins() async {
    try {
      final List<dynamic> rawData = await _remoteDS.getRawCoinsData(
          ["QTUMETH", "BTCUSDT", "ETHUSDT", "BNBUSDT", "SOLUSDT", "ADAUSDT", "LINKUSDT"]);
      return rawData.map((json) => CoinModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Error in getting data: $e");
    }
  }

  Future<List<CoinModel>> getAllCoins() async {
    try {
      final List<dynamic> rawData = await _remoteDS.getRawCoinsData();
      return rawData.map((json) => CoinModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Error fetching coins: $e");
    }
  }

  Future<List<CoinModel>> getFavorites() async {
    final favorites = await _localDS.getFavoriteCoins();
    return favorites.map((map) {
      return CoinModel(
        price: map['price'].toString(),
        PriceChangePercent: map['priceChangePercent'] ?? "0.0",
        symbol: map['symbol'] ?? "",
      );
    }).toList();
  }

  Future<bool> isFavorite(String symbol) async {
    final favorites = await _localDS.getFavoriteCoins();
    return favorites.any((coin) => coin['symbol'] == symbol);
  }

  Future<void> toggleFavorite(CoinModel coin) async {
    final isFav = await isFavorite(coin.symbol);
    if (isFav) {
      await _localDS.removeFromFavorite(coin.symbol);
    } else {
      await _localDS.addToFavorite(coin);
    }
  }

  String getUserName() => _localDS.getUserName();

  String getUserEmail() => _localDS.getUserEmail();
}
