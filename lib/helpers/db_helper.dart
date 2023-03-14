import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    final dbPath = await getDatabasesPath();
    final db =
        await openDatabase(join(dbPath, 'places.db'), onCreate: (db, version) {
      return db.execute('');
    }, version: 1);
  }
}
