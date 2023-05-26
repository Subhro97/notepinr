import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'notes_list.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE notes_list(id INTEGER PRIMARY KEY autoincrement, title TEXT, description TEXT, priority TEXT, pinned INTEGER, date TEXT, time TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    await db.close();
  }

  static Future<List<Map<String, Object?>>> getAllNotes(String table) async {
    final db = await DBHelper.database();
    final res = await db.query(table);
    await db.close();
    return res;
  }

  static Future<List<Map<String, Object?>>> getNote(
      String table, int id) async {
    final db = await DBHelper.database();
    final res = await db.query(table, where: 'id = ?', whereArgs: [id]);
    await db.close();
    return res;
  }

  static Future<int> deleteNote(String table, int id) async {
    final db = await DBHelper.database();
    final res = db.delete(table, where: 'id: ?', whereArgs: [id]);
    await db.close();
    return res;
  }

  static Future<int> deleteAllNotes(String table) async {
    final db = await DBHelper.database();
    final res = db.delete(table);
    await db.close();
    return res;
  }
}
