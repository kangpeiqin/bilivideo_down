import 'package:bilivideo_down/controller/bindings/controller_binding.dart';
import 'package:bilivideo_down/controller/theme_controller.dart';
import 'package:bilivideo_down/router/router_config.dart';
import 'package:bilivideo_down/storage/init_repository.dart';
import 'package:bilivideo_down/window_config/windows_adapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sp_util/sp_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowAdapter.setSize();
  await InitRepository.instance.initDb();
  await SpUtil.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return GetMaterialApp.router(
      routerDelegate: routerConfig.routerDelegate,
      routeInformationParser: routerConfig.routeInformationParser,
      routeInformationProvider: routerConfig.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinding(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      themeMode:
          themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
