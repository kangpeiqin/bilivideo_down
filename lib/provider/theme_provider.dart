import 'package:bilivideo_down/constant/sp_key.dart';
import 'package:bilivideo_down/model/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sp_util/sp_util.dart';

final themeProvider = StateNotifierProvider<ThemeService, ThemeState>((ref) {
  final themeService = ThemeService();
  // Initialize the theme service
  themeService.init();
  return themeService;
});

class ThemeService extends StateNotifier<ThemeState> {
  ThemeService()
      : super(const ThemeState(isDark: false, themeMode: ThemeMode.light));

  // Initialize ThemeState
  void init() {
    bool isDark = SpUtil.getBool(SpKey.isDarkTheme) ?? false;
    state = state.copyWith(isDark: isDark, themeMode: getThemeMode(isDark));
  }

  ThemeMode getThemeMode(bool isDark) {
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchThemeMode() async {
    bool isDark = !state.isDark;
    state = state.copyWith(isDark: isDark, themeMode: getThemeMode(isDark));
    await SpUtil.putBool(SpKey.isDarkTheme, isDark);
  }
}
