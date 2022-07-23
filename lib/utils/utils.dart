import 'package:flutter/material.dart';

String dateToTime(BuildContext context, {required DateTime date}) =>
    TimeOfDay.fromDateTime(date).format(context);

String printDuration(Duration? duration) {
  if (duration != null) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours == 0) return "$twoDigitMinutes:$twoDigitSeconds";
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
  return '';
}
