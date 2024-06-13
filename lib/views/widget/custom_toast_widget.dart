import 'package:flutter/material.dart';

//自定义
class CustomToast {
  late final OverlayEntry _overlayEntry;
  late final BuildContext _context;
  late final GlobalKey _inputKey;
  String message;
  Duration showDuration;
  Widget iconWidget;

  CustomToast({
    required BuildContext context,
    required GlobalKey inputKey,
    this.message = "",
    this.iconWidget = const Icon(Icons.rocket, color: Colors.white),
    this.showDuration = const Duration(seconds: 2),
  })  : _context = context,
        _inputKey = inputKey {
    _overlayEntry = _createOverlayEntry();
  }

  OverlayEntry _createOverlayEntry() {
    Overlay.of(_context);
    final inputPosition = _findInputBoxPosition(_inputKey);

    final topPosition = inputPosition.dy - 160;

    return OverlayEntry(
      builder: (context) => Positioned(
        top: topPosition,
        left: inputPosition.dx + 80,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                iconWidget,
                // const Icon(Icons.close, color: Colors.red),
                const SizedBox(width: 4), // 图标和文本之间的空间
                Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Offset _findInputBoxPosition(GlobalKey key) {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
  }

  void showInDuration() {
    Overlay.of(_context).insert(_overlayEntry);
    Future.delayed(showDuration).then((value) {
      hide();
    });
  }

  void show() {
    Overlay.of(_context).insert(_overlayEntry);
  }

  void hide() {
    if (_overlayEntry.mounted) {
      _overlayEntry.remove();
    }
  }
}
