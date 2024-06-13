class CommonUtil {
  static String formatBytes(int bytes) {
    const List<String> suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
    int index = 0;
    double size = bytes.toDouble();
    while (size > 1024 && index < suffixes.length - 1) {
      size /= 1024;
      index++;
    }
    return '${size.toStringAsFixed(2)} ${suffixes[index]}';
  }

  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  static String transferDuration(int duration) {
    if (duration < 0) {
      return 'Invalid duration';
    }

    int durationInSeconds = duration ~/ 1000;
    int minutes = (durationInSeconds ~/ 60);
    int seconds = durationInSeconds % 60;

    return '$minutes分钟$seconds秒';
  }
}
