import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
part 'theme_state.mapper.dart';

@MappableClass()
class ThemeState with ThemeStateMappable {
  final bool isDark;
  final ThemeMode themeMode;
  const ThemeState({
    required this.isDark,
    required this.themeMode,
  });
}
