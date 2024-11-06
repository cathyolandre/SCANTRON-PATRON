import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'transaction_log.db');
    return await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE transactions(id INTEGER PRIMARY KEY, transaction TEXT, date TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> addTransaction(String transaction) async {
    final db = await database;
    String date = DateTime.now().toIso8601String();
    await db.insert(
      'transactions',
      {'transaction': transaction, 'date': date},
    );
  }

  Future<List<Map<String, dynamic>>> getTransactions() async {
    final db = await database;
    return await db.query('transactions', orderBy: 'date DESC');
  }
}
