import 'package:first_flutter_project/core/local/DbHelper.dart';
import 'package:first_flutter_project/core/local/PrefHelper.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSource {
  final DbHelper _dbHelper;


  LocalDataSource(this._dbHelper);

  Future<int> registerUser(Map<String, dynamic> user) async {
    final db = await _dbHelper.db;
    return await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await _dbHelper.db;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'email =? AND password =?',
      whereArgs: [email, password],
    );
    if (results.isNotEmpty) {
      await PrefHelper.setUserLoggedIn(true);
      await PrefHelper.saveUserName(results.first['name']);
      await PrefHelper.saveUserEmail(results.first['email']);
      return results.first;
    }
    return null;
  }


  bool hasSession() {
    return PrefHelper.getUserLoggedIn();
  }

  Future<void> clearSession() async {
    await PrefHelper.logout();
  }

  Future<int> addToFavorite(dynamic coin) async {
    final db = await _dbHelper.db;
    return await db.insert(
      'favorites',
      {
        'symbol': coin.symbol,
        'price': double.tryParse(coin.price.toString()) ?? 0.0,
        'priceChangePercent': coin.PriceChangePercent,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> removeFromFavorite(String symbol) async {
    final db = await _dbHelper.db;
    return await db.delete(
      'favorites',
      where: 'symbol = ?',
      whereArgs: [symbol],
    );
  }

  Future<List<Map<String, dynamic>>> getFavoriteCoins() async {
    final db = await _dbHelper.db;
    return await db.query('favorites');
  }

  String getUserName() => PrefHelper.getUserName();
  String getUserEmail() => PrefHelper.getUserEmail();
}
