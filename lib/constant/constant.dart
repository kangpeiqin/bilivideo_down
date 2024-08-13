import 'package:flutter/foundation.dart';

class Constant {
  static bool isDriverTest = false;
  static bool isUnitTest = false;

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';

  static const bool inProduction = kReleaseMode;

  static const String baseAssetPath = 'assets/images';

  static const String logoImagePath = '$baseAssetPath/logo.png';

  static const String appIconPath = '$baseAssetPath/app_icon.png';

  static const String emptyImagePath = '$baseAssetPath/nothing.png';

  static const String dbPath = 'assets/flutter.db';
}
