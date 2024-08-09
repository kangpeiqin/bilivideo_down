import 'package:flutter/foundation.dart';

bool isDesktop() {
  return checkPlatform(
      [TargetPlatform.linux, TargetPlatform.windows, TargetPlatform.macOS]);
}

bool checkPlatform(List<TargetPlatform> platforms, {bool web = false}) {
  if (web && kIsWeb) {
    return true;
  }
  return platforms.contains(defaultTargetPlatform);
}

/// This platform can receive share intents
bool isMobile() {
  return checkPlatform([TargetPlatform.android, TargetPlatform.iOS]);
}
