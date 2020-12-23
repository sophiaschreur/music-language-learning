import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Song {
  int _id;
  String _videoID;
  String _lyrics;
  String _author;
  String _title;

  Song(this._videoID, this._lyrics, this._author, this._title);

  Song.map(dynamic obj) {
    this._id = obj['id'];
    this._videoID = obj['videoID'];
    this._lyrics = obj['lyrics'];
    this._author = obj['author'];
    this._title = obj['title'];
  }

  int get id => _id;
  String get videoID => _videoID;
  String get lyrics => _lyrics;
  String get author => _author;
  String get title => _title;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['videoID'] = _videoID;
    map['lyrics'] = _lyrics;
    map['author'] = _author;
    map['title'] = _title;

    return map;
  }

  Song.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._videoID = map['videoID'];
    this._lyrics = map['lyrics'];
    this._author = map['author'];
    this._title = map['title'];
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableSong = 'songTable';
  final String columnId = 'id';
  final String columnVideoID = 'videoID';
  final String columnLyricsWords = 'lyrics';
  final String columnAuthor = 'author';
  final String columnTitle = 'title';

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'songs.db');

    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableSong($columnId INTEGER PRIMARY KEY, $columnVideoID TEXT, $columnLyricsWords TEXT, $columnAuthor TEXT, $columnTitle TEXT)');
  }

  Future<int> saveSong(Song song) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableSong, song.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');

    return result;
  }

  Future<List> getAllSongs() async {
    var dbClient = await db;
    var result = await dbClient.query(tableSong, columns: [
      columnId,
      columnVideoID,
      columnLyricsWords,
      columnAuthor,
      columnTitle
    ]);
    print('allSongsList');
    print(result.toList());
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableSong'));
  }

  Future<String> getLyricsFromVideoID(String videoID) async {
    var dbClient = await db;
    // var result = await dbClient.query(tableSong, columns: [columnId, columnUrl, columnLyrics, columnPic]);
    var result = await dbClient
        .rawQuery('SELECT * FROM $tableSong WHERE $columnVideoID = "$videoID"');
    print('result.length');
    print(result.length);
    if (result.length == 0) {
      return '';
    } else {
      return result[0]['lyrics'];
    }
  }

  Future<int> getIDFromVideoID(String videoID) async {
    var dbClient = await db;
    // var result = await dbClient.query(tableSong, columns: [columnId, columnUrl, columnLyrics, columnPic]);
    var result = await dbClient
        .rawQuery('SELECT * FROM $tableSong WHERE $columnVideoID = "$videoID"');

    return result[0]['id'];
  }

  Future<String> getLyricsFromID(int id) async {
    var dbClient = await db;
    // var result = await dbClient.query(tableSong, columns: [columnId, columnUrl, columnLyrics, columnPic]);
    var result = await dbClient
        .rawQuery('SELECT * FROM $tableSong WHERE $columnId = "$id"');

    return result[0]['lyrics'];
  }

  Future<String> getVideoIDFromID(int id) async {
    var dbClient = await db;
    // var result = await dbClient.query(tableSong, columns: [columnId, columnUrl, columnLyrics, columnPic]);
    var result = await dbClient
        .rawQuery('SELECT * FROM $tableSong WHERE $columnId = "$id"');

    return result[0]['videoID'];
  }

  Future<int> deleteSongByVideoID(String videoId) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableSong, where: '$columnVideoID = ?', whereArgs: [videoId]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }
}
