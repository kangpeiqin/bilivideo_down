import 'package:bilivideo_down/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSwitchIcon extends ConsumerWidget {
  const ThemeSwitchIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeProvider = ref.watch(themeProvider);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          ref.read(themeProvider.notifier).switchThemeMode();
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 16),
          child: Icon(
            appThemeProvider.isDark
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
            color: appThemeProvider.isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
