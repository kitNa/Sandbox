import '02_string_case_extension.dart';
import '02_string_operators_extension.dart';

void main() {
  var name = 'Katya';
  print(name.capitalize());

  print('------------------');
  print('katya - a = ${name - 'a'}');
  print('katya - ty = ${name - 'ty'}');
  print('Katya - T = ${name - 'T'}');
  print('katya - KATY = ${name - 'KATY'}');
}
