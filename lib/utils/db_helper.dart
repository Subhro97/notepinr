import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'notes_list.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE notes_list(id INTEGER PRIMARY KEY autoincrement, title TEXT, description TEXT, priority TEXT, pinned INTEGER, date TEXT, time TEXT, checked INTEGER)');
    }, onUpgrade: (db, oldVersion, newVersion) {
      if (oldVersion < 2) {
        // Add the "checked" column to the existing table
        return db.execute(
            'ALTER TABLE notes_list ADD COLUMN checked INTEGER DEFAULT 0');
      }
    }, version: 2);
  }

  static Future<int> insert(String table, Map<String, Object?> data) async {
    final db = await DBHelper.database();
    int id = await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    await db.close();
    return id;
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
    final res = await db.delete(table, where: 'id = ?', whereArgs: [id]);
    await db.close();
    return res;
  }

  static Future<int> deleteAllNotes(String table) async {
    final db = await DBHelper.database();
    final res = await db.delete(table);
    await db.close();
    return res;
  }

  static Future<Map<String, bool>> getPinNcheckedStatus(
      String table, int id) async {
    final db = await DBHelper.database();
    final res = await db.query(
      table,
      columns: ['pinned', "checked"],
      where: 'id = ?',
      whereArgs: [id],
    );
    await db.close();

    Map<String, bool> finalRes = {"pinned": false, "checked": false};

    if (res.isNotEmpty) {
      finalRes['pinned'] = res[0]['pinned'] as int == 1 ? true : false;
      finalRes["checked"] = res[0]['checked'] as int == 1 ? true : false;
    }

    return finalRes;
  }

  static Future<void> updatePinStatus(
    String table,
    int id,
    int pinnedStatus,
  ) async {
    final db = await DBHelper.database();

    await db.update(
      table,
      {'pinned': pinnedStatus},
      where: 'id = ?',
      whereArgs: [id],
    );
    await db.close();
  }

  static Future<void> updateNote(
    String table,
    int id,
    Map<String, Object?> data,
  ) async {
    final db = await DBHelper.database();

    await db.update(
      table,
      {
        'title': data['title'],
        'description': data['description'],
        'pinned': data['pinned'],
        'priority': data['priority'],
        'date': data['date'],
        'time': data['time'],
        'checked': data['checked']
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    await db.close();
  }

  static Future<void> updateCheckedStatus(
    String table,
    int id,
    bool checkedStatus,
  ) async {
    final db = await DBHelper.database();

    await db.update(
      table,
      {'checked': checkedStatus == true ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    await db.close();
  }
}
