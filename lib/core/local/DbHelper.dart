import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  _initDb() async {
    String path = join(await getDatabasesPath(), 'crypto_app.db');
    return await openDatabase(
      path,
      version: 3,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS favorites (
              symbol TEXT PRIMARY KEY,
              price REAL,
              priceChangePercent TEXT
            )
          ''');
        }
        if (oldVersion < 3) {
          // This ensures that even if users missed version 2, they get the table now.
          await db.execute('''
            CREATE TABLE IF NOT EXISTS favorites (
              symbol TEXT PRIMARY KEY,
              price REAL,
              priceChangePercent TEXT
            )
          ''');
        }
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            password TEXT,
            name TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE favorites (
            symbol TEXT PRIMARY KEY,
            price REAL,
            priceChangePercent TEXT
          )
        ''');
      },
    );
  }
}
