import 'dart:io';

import 'package:bilivideo_down/constant/sp_key.dart';
import 'package:bilivideo_down/window_config/window_buttons.dart';
import 'package:bilivideo_down/window_config/windows_adapter.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sp_util/sp_util.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String _storagePath;

  @override
  void initState() {
    super.initState();
    _loadStoragePath();
  }

  Future<void> _loadStoragePath() async {
    _storagePath = SpUtil.getString(SpKey.storagePath) ?? '';
    if (_storagePath.isEmpty) {
      _storagePath = (await getDownloadsDirectory())!.path;
      SpUtil.putString(SpKey.storagePath, _storagePath);
    }
    setState(() {});
  }

  Future<void> _pickStoragePath() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      setState(() {
        _storagePath = selectedDirectory;
        SpUtil.putString(SpKey.storagePath, _storagePath);
      });
    }
  }

  Future<void> _openCurrentDirectory() async {
    if (Directory(_storagePath).existsSync()) {
      if (Platform.isWindows) {
        await Process.run('explorer', [_storagePath]);
      } else if (Platform.isMacOS) {
        await Process.run('open', [_storagePath]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: DragToMoveArea(
            child: AppBar(
              actions: const [WindowButtons()],
            ),
          )),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text("更改存储目录"),
            subtitle: Text(_storagePath),
            onTap: _pickStoragePath,
          ),
          ListTile(
            title: const Text("预览存储目录"),
            onTap: _openCurrentDirectory,
          ),
        ],
      ),
    );
  }
}
