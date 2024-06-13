import 'package:flutter/foundation.dart';

class Constant {
  static bool isDriverTest = false;
  static bool isUnitTest = false;

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';

  static const bool inProduction = kReleaseMode;

  static const String _baseAssetPath = 'assets/images';

  static const String logoImagePath = '$_baseAssetPath/logo.png';

  static const String appIconPath = '$_baseAssetPath/app_icon.png';
}
