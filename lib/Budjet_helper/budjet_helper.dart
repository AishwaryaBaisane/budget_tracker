
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper dbHelper = DbHelper._();

  DbHelper._();

  Database? _db;

  Future get database async => _db ?? await initDatabase();

  Future initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'finance.db');

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql = '''CREATE TABLE finance(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        isIncome INTEGER NOT NULL,
        category TEXT);
        ''';
        await db.execute(sql);
      },
    );
    return _db;
  }

  Future insertData(double amount, int isIncome, String category) async {
    Database? db = await database;
    String sql = '''INSERT INTO finance (amount,isIncome,category)
    VALUES (?,?,?);
    ''';
    List args = [amount, isIncome, category];
    await db!.rawInsert(sql, args);
  }

  Future<List<Map>> readData() async {
    Database? db = await database;
    String sql = '''SELECT * FROM finance''';
    return await db!.rawQuery(sql);
  }

  Future deleteData(int id) async {
    Database? db = await database;
    String sql = '''DELETE FROM finance WHERE id = ?''';
    List args = [id];
    await db!.rawDelete(sql, args);
  }

  Future<void> updateData(
      int id, double amount, int isIncome, String category) async {
    Database? db = await database;
    String sql =
    '''UPDATE finance SET amount=?,isIncome=?,category=? WHERE  id=?;''';
    List args = [amount, isIncome, category, id];
    await db!.rawUpdate(sql, args);
  }
}