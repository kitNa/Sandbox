import 'package:intl/intl.dart';
import 'package:sandbox/src/exercises/16_extension_methods/01_string_time_extension.dart';
import '01_date_time_extension.dart';

void main() {
  print('DateTime to time:');
  DateTime dateTime = DateTime.now();
  print(dateTime.format('hh:mm'));
  print(dateTime.format('hh:mm:ss'));
  print('String to dateTime:');
  var stringTime = '15:42';
  DateTime date = stringTime.parseTime('hh:mm');
  print(date);
  print('-----------------------------');
  stringTime = '15:42:12';
  date = stringTime.parseTime('HH:mm');
  print(date);
  print('-----------------------------');
  stringTime = '15:42:12';
  date = stringTime.parseTime('HH:mm:ss');
  print(date);
  print('-----------------------------');
  stringTime = '15';
  //Unhandled exception:
  // FormatException: Trying to read : from 15 at 3
  //date = stringTime.parseTime('HH:mm:ss');
}
