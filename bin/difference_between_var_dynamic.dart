void main() {
  print('***************************************');
  print('Declaration of a variable with initialization and keyword var:');
  var a = 'abc';
  print('a is ${a.runtimeType} with value ($a)');
  print('a length is ${a.length}');
  //a = 12345; -  Error: A value of type 'int' can't be assigned to a variable of type 'String'.
  print('Assignment of a value of another type is impossible!');

  print('\n***************************************');
  print('Declaring a variable with the var keyword without initialization:');
  var b;
  print('b is ${b.runtimeType} with value ($b)');
  // print('b length is ${b.length}'); - The getter 'length' was called on null.
  b = 'abc';
  print('b is ${b.runtimeType} with value ($b)');
  print('b length is ${b.length}');
  b = 12345;
  print('b is ${b.runtimeType} with value ($b)');
  //print('b length is ${b.length}'); -  Class 'int' has no instance getter 'length'

  print('\n***************************************');
  print('Declaration of a dynamic variable with initialization:');
  dynamic c = 'abc';
  print('c is ${c.runtimeType} with value ($c)');
  print('c length is ${c.length}');
  c = 12345;
  print('c is ${c.runtimeType} with value ($c)');
  //print('c length is ${c.length}');-  Class 'int' has no instance getter 'length'

  print('\n***************************************');
  print('Declaring a dynamic variable without initialization:');
  dynamic d;
  print('d is ${d.runtimeType} with value ($d)');
  //print('d length is ${d.length}');  - The getter 'length' was called on null.
  d = 'abc';
  print('d is ${d.runtimeType} with value ($d)');
  print('d length is ${d.length}');
  d = 12345;
  print('d is ${d.runtimeType} with value ($d)');
  //print('d length is ${d.length}'); -  Class 'int' has no instance getter 'length'

  //
}
