import 'package:bilivideo_down/storage/init_repository.dart';
import 'package:bilivideo_down/window_config/windows_adapter.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowAdapter.setSize();
  await InitRepository.instance.initDb();
  await SpUtil.getInstance();
}
