import 'dart:io';

import 'package:bilivideo_down/storage/db_open_helper.dart';
import 'package:bilivideo_down/storage/flutter_db_storage.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class InitRepository {
  InitRepository._();

  static InitRepository instance = InitRepository._();

  Future<void> initDb() async {
    DbOpenHelper.setupDatabase();
    String databasesPath = await DbOpenHelper.getDbDirPath();
    String dbPath = path.join(databasesPath, "flutter.db");
    bool shouldCopy = await _checkShouldCopy(dbPath);
    if (shouldCopy) {
      await _doCopyAssetsDb(dbPath);
    } else {
      LogUtil.v("=====flutter.db 已存在====");
    }
    LogUtil.v('====数据库所在文件夹: $databasesPath=======');

    await FlutterDbStorage.instance.initDb();
  }

  Future<void> _doCopyAssetsDb(String dbPath) async {
    Directory dir = Directory(path.dirname(dbPath));
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    ByteData data = await rootBundle.load("lib/assets/flutter.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes, flush: true);

    LogUtil.v("=====flutter.db==== assets ======拷贝完成====");
  }

  Future<bool> _checkShouldCopy(String dbPath) async {
    bool shouldCopy = false;
    // const isProd = bool.fromEnvironment('dart.vm.product');
    // if (!isProd) {
    //   shouldCopy = true;
    // }

    if (!File(dbPath).existsSync()) {
      shouldCopy = true;
    }
    return shouldCopy;
  }
}
