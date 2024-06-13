import 'package:bilivideo_down/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSwitchIcon extends StatelessWidget {
  const ThemeSwitchIcon({super.key});

  @override
  Widget build(BuildContext context) {
    var themeController = Get.find<ThemeController>();
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          themeController.switchThemeMode();
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 16),
          child: Obx(
            () => Icon(
              themeController.isDark.value
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              color: themeController.isDark.value ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
