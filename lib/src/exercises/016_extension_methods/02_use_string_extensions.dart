import '02_string_case_extension.dart';
import '02_string_operators_extension.dart';

void main() {
  var name = 'katya';
  print(name.capitalize());

  print('------------------');
  print('katya - Tty = ${name - 'Kty'}');
  print('katya - ty = ${name - 'ty'}');
  print('katya - T = ${name - 'T'}');
  print('katya - KATY = ${name - 'KATY'}');
}
