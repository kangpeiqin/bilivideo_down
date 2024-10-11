import 'package:bilivideo_down/storage/init_repository.dart';
import 'package:bilivideo_down/window_config/windows_adapter.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowAdapter.setSize();
  await InitRepository.instance.initDb();
  LogUtil.init();
  await SpUtil.getInstance();
}
