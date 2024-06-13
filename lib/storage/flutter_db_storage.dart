import 'dart:io';

import 'package:bilivideo_down/storage/dao/video_info_dao.dart';
import 'package:bilivideo_down/storage/db_open_helper.dart';
import 'package:bilivideo_down/util/log_util.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class FlutterDbStorage {
  Database? _database;

  FlutterDbStorage._();

  static FlutterDbStorage instance = FlutterDbStorage._();

  late VideoInfoDao _videoInfoDao;

  VideoInfoDao get videoInfoDao => _videoInfoDao;

  Database get db => _database!;

  Future<void> initDb({String name = "flutter.db"}) async {
    if (_database != null) return;
    String databasesPath = await DbOpenHelper.getDbDirPath();
    String dbPath = path.join(databasesPath, name);

    if (Platform.isWindows || Platform.isLinux) {
      DatabaseFactory databaseFactory = databaseFactoryFfi;
      _database = await databaseFactory.openDatabase(
        dbPath,
        options: OpenDatabaseOptions(),
      );
    } else {
      _database = await openDatabase(dbPath);
    }
    _videoInfoDao = VideoInfoDao(_database!);
    Log.d('初始化数据库....');
  }

  Future<void> closeDb() async {
    await _database?.close();
    _database = null;
  }
}
