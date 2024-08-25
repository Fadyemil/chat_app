import 'package:intl/intl.dart';

class MyDateTime {
  static DateTime dateFormat({required String time}) {
    var dt = _parseDateTime(time);
    return DateTime(dt.year, dt.month, dt.day);
  }

  static String timeDate({required String time}) {
    var dt = _parseDateTime(time);
    return DateFormat('jm').format(dt).toString();
  }

  static String dateAndTime({required String time}) {
    String dat = '';
    final today = DateTime.now();
    final yesterday = DateTime.now().add(const Duration(days: -1));
    var dt = _parseDateTime(time);

    final t = DateTime(today.year, today.month, today.day);
    final y = DateTime(yesterday.year, yesterday.month, yesterday.day);
    final d = DateTime(dt.year, dt.month, dt.day);
    if (d == t) {
      dat = 'Today';
    } else if (d == y) {
      dat = 'Yesterday';
    } else if (dt.year == today.year) {
      dat = DateFormat.MMMd().format(dt).toString();
    } else {
      dat = DateFormat.yMMMd().format(dt).toString();
    }
    return dat;
  }

  static DateTime _parseDateTime(String time) {
    try {
      // Attempt to parse as milliseconds since epoch (if the input is a number)
      return DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    } catch (e) {
      // If it fails, assume the input is a standard datetime string
      return DateTime.parse(time);
    }
  }
}
