extension IntExt on int {
  String get formattedTimer {
    int sec = this % 60;
    int min = (this / 60).floor();
    String minute = min.toString().length <= 1 ? '0$min' : '$min';
    String second = sec.toString().length <= 1 ? '0$sec' : '$sec';
    return '$minute:$second';
  }
}
