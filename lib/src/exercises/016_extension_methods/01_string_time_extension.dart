import 'package:intl/intl.dart';

extension MyDateTimeParse on String {
  DateTime parseTime(String pattern) {
    var dateTime = DateFormat(pattern).parse(this);
    return dateTime;
  }
}
