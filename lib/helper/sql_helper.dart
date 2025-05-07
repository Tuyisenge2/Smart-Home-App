import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  
  static Future<void> createTables(sql.Database database) async {
    await database.execute(''' CREATE TABLE IF NOT EXISTS devices(
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  imageUrl TEXT,
  name TEXT,
  roomId INTEGER,
  createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  ) 
  ''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'smarthome',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createDevice(
    String name,
    int roomId,
    String imageurl,
  ) async {
    print(
      'imragewwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwrr $imageurl',
    );
    final db = await SQLHelper.db();
    final data = {'name': name, 'roomId': roomId, 'imageUrl': imageurl};
    final id = await db.insert(
      'devices',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> getDevices() async {
    final db = await SQLHelper.db();
    final response = await db.query('devices', orderBy: "id");
    return response;
  }

  static Future<List<Map<String, dynamic>>> getDev(int id) async {
    final db = await SQLHelper.db();
    return db.query('devices', where: "id=?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateDevice(
    int? id,
    String? name,
    int? roomId,
    String? imageurl,
    String? newImageUrl,
  ) async {
    final db = await SQLHelper.db();
    final data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (roomId != null) data['roomId'] = roomId;
    if (newImageUrl != null) data['imageUrl'] = newImageUrl;
    if (data.isEmpty) {
      throw Exception('No fields provided for update');
    }
    data['createdAt'] = DateTime.now().toString();
    final result = await db.update(
      'devices',
      data,
      where: "imageUrl=?",
      whereArgs: [imageurl],
    );
    return result;
  }

  static Future<void> deleteDevice(String imageUrl) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('devices', where: "imageUrl=?", whereArgs: [imageUrl]);
    } catch (e) {
      debugPrint("Something went wrong when deleting an item: $e");
    }
  }
}
