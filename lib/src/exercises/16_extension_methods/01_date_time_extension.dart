import 'package:intl/intl.dart';

extension MyDateTimeExtension on DateTime {
  String format(String pattern) {
    var dateFormat = DateFormat(pattern).format(this);
    return dateFormat;
  }
}
