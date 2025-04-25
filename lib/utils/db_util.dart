import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sqflite;

class DBUtil {
  static const String dbName = 'great_places_flutter.db';
  static const int dbVersion = 1;

  static Future<sqflite.Database> database() async {
    final dbPath = await sqflite.getDatabasesPath();
    return sqflite.openDatabase(
      path.join(dbPath, dbName),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
      version: dbVersion,
    );
  }

  static Future<void> upsert(String table, Map<String, dynamic> data) async {
    final db = await database();
    await db.insert(table, data, conflictAlgorithm: sqflite.ConflictAlgorithm.replace);
  }
}
