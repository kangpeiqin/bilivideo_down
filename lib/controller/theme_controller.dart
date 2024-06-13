import 'package:bilivideo_down/constant/sp_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadThemeMode();
  }

  void loadThemeMode() async {
    isDark.value = SpUtil.getBool(SpKey.isDarkTheme) ?? false;
  }

  void switchThemeMode() async {
    isDark.value = !isDark.value;
    await SpUtil.putBool(SpKey.isDarkTheme, isDark.value);
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }
}
