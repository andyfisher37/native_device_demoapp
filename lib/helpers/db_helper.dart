import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // Function for get database db not found they create...
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'user_places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places (id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  // Function insert data in db
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Function for get data from db...
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
