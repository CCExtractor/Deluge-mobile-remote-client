import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbbucketManager {
  Database _database;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(), "auth.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE bucket(id INTEGER PRIMARY KEY autoincrement, deluge_url TEXT ,has_deluge_pwrd TEXT,deluge_pwrd TEXT,is_reverse_proxied TEXT,via_qr Text, username TEXT,password TEXT)",
        );
      });
    }
  }

  Future<int> insertbucket(Bucket bucket) async {
    await openDb();
    return await _database.insert('bucket', bucket.toMap());
  }

  Future<List<Bucket>> getbucketitem() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('bucket');
    return List.generate(maps.length, (i) {
      return Bucket(
        id: maps[i]['id'],
        deluge_url: maps[i]['deluge_url'],
        has_deluge_pwrd: maps[i]['has_deluge_pwrd'],
        deluge_pwrd: maps[i]['deluge_pwrd'],
        is_reverse_proxied: maps[i]['is_reverse_proxied'],
        username: maps[i]['username'],
        password: maps[i]['password'],
        via_qr: maps[i]['via_qr'],
      );
    });
  }

  Future<int> updatebucket(Bucket bucket) async {
    await openDb();
    return await _database.update('bucket', bucket.toMap(),
        where: "id = ?", whereArgs: [bucket.id]);
  }

  Future<void> deletebucket(int id) async {
    await openDb();
    await _database.delete('bucket', // it is db name
        where: "id = ?",
        whereArgs: [id]);
  }

  //--
  Future<Bucket> get_acc_by_id(int id) async {
    await openDb();
    final List<Map<dynamic, dynamic>> maps =
        await _database.query('bucket', where: "id=?", whereArgs: [id]);

    return Bucket(
      id: maps[0]['id'],
      deluge_url: maps[0]['deluge_url'],
      has_deluge_pwrd: maps[0]['has_deluge_pwrd'],
      deluge_pwrd: maps[0]['deluge_pwrd'],
      is_reverse_proxied: maps[0]['is_reverse_proxied'],
      username: maps[0]['username'],
      password: maps[0]['password'],
      via_qr: maps[0]['via_qr'],
    );
  }

  Future<void> delete_table() async {
    await openDb();
    await _database.execute("DROP TABLE bucket");
    await _database.execute(
        "CREATE TABLE bucket(id INTEGER PRIMARY KEY autoincrement, deluge_url TEXT ,has_deluge_pwrd TEXT,deluge_pwrd TEXT,is_reverse_proxied TEXT,via_qr Text, username TEXT,password TEXT)");
  }
} //root class

class Bucket {
  int id;
  String deluge_url;
  String deluge_pwrd;
  String has_deluge_pwrd;
  String is_reverse_proxied;
  String via_qr;
  String username;
  String password;

  Bucket(
      {@required this.deluge_url,
      @required this.deluge_pwrd,
      this.id,
      @required this.has_deluge_pwrd,
      @required this.is_reverse_proxied,
      @required this.username,
      @required this.password,
      @required this.via_qr});
  Map<String, dynamic> toMap() {
    //return {'name': name, 'course': course};
    return {
      'id': id,
      'deluge_url': deluge_url,
      'has_deluge_pwrd': has_deluge_pwrd,
      'deluge_pwrd': deluge_pwrd,
      'is_reverse_proxied': is_reverse_proxied,
      'via_qr': via_qr,
      'username': username,
      'password': password
    };
  }
}
//-------------
