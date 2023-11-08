import 'dart:ffi';

void main() {
  // https://dart.dev/language/functions

  // TODO: create exercises

  // 1. Named params

  // 2. Combine named + positional params

  // 3. Required named params

  // 4. Optional positional params

  namedParams();
  optionalPositionalParams();
}

//Імена функцій потрібно писати з великої літери?
//Чи можна робити перевантаження функцій?
void namedParams() {
  //1. Create a function with nullable named parameters that will print a person's last
  // name and first name.
  print('\n***namedParams1***\n');
  void printFullName({String? firstName, String? lastName}) {
    print("Ім'я: $firstName\n"
        "Прізвище: $lastName");
  }
  printFullName(); //Ім'я: null, Прізвище: null
  printFullName(
      lastName: 'Radchenko',
      firstName: 'Lena'); //Ім'я: Lena Прізвище: Radchenko
  printFullName(lastName: 'Radchenko'); //Ім'я: null Прізвище: Radchenko

  // 1.1 Create a function "splitStr" which will split a string into a list of substrings. It should have the following
  // named parameters:
  // - "str" - the string to split (required)
  // - "separator" - the delimiter to use when splitting the string (optional, defaults to ",")
  // - "trimWhitespace" - whether to trim whitespace from the substrings (optional, defaults to true)
  // splitStr(str: "hello,world");       // separator = ",", trimWhitespace = true
  // splitStr(str: "hello world", separator: " "); // trimWhitespace = true
  // splitStr(str: "hello world", trimWhitespace: false); // separator = ","
  print('\n***namedParams1.1***\n');
  String splitStr({required String str,
    String separator = ',',
    bool trimWhitespace = true}) {
    return trimWhitespace
        ? str.split(separator).toString().trim()
        : str.split(separator).toString();
  }
  print(splitStr(
      str: "the first - Petrov,  the second Ivanov,  the third - Skvortsov"));
  print(splitStr(str: "I love my kid", separator: " "));
  print(splitStr(
      str: "   the first - Petrov, the second Ivanov, the third - Skvortsov  ",
      separator: ", ",
      trimWhitespace: false));

  //2. Create a function with required  named parameters that will print information about
  // the purchase of any product. Use the following parameters: date, seller, product, price, quantity
  print('\n***namedParams2***\n');
  void printPurchaseInformation({required DateTime date,
    required String seller,
    required String product,
    required double price,
    required int quantity}) {
    print("дата: $date\n "
        "продавець: $seller\n "
        "товар: $product \n "
        "ціна: $priceгрн\n "
        "кількість: $quantity\n "
        "вартість: ${price * quantity}");
  }

  printPurchaseInformation(
      date: DateTime.now(),
      seller: 'Василь',
      product: 'Ручка',
      price: 5.5,
      quantity: 20);
  //printPurchaseInformation(); //The named parameters is required, but there's no corresponding argument

  // 3. Make function from (1.1) to be combined - "str" should be first positional parameter, and "separator" and
  // "trimWhitespace" should be optional named parameters with default values.
  // splitStr("hello,world");       // separator = ",", trimWhitespace = true
  // splitStr("hello world", separator: " "); // trimWhitespace = true
  print('\n***namedParams3***\n');
  String splitStr1(String str,
      {String separator = ',', bool trimWhitespace = true}) {
    return trimWhitespace
        ? str.split(separator).toString().trim()
        : str.split(separator).toString();
  }
  print(splitStr1('Hello, world'));
  print(splitStr1(separator: 'Hello, world   ', ', ', trimWhitespace: false));

  // You might want to place positional arguments first, but Dart doesn’t require it. Dart allows named arguments to be
  // placed anywhere in the argument list when it suits your API

  // 3.1 Call function from previous exercise specifying named parameters first.
  // splitStr(separator: " ", "hello world"); // trimWhitespace = true
  // splitStr(separator: " ", trimWhitespace: true, "hello world");
  // and try this too: splitStr(separator: " ", "hello world", trimWhitespace: true);   // NEVER DO THIS in real code
  print('\n***namedParams3.1***\n');
  print(splitStr1(separator: ', ', ' Hello ,  world   ', trimWhitespace: true));
  print(splitStr1(separator: ', ', trimWhitespace: false, ' Hello , world '));

  // 4. Create a "repeat" function which will work as a "for" loop. It should have the following parameters:
  // - "times" - how many times to repeat (required)
  // - positional - void Function<int> the function to call (required),
  // repeat(times: 100, (i) => print(i));   // prints 0, 1, 2, 3, .... 99
  print('\n***namedParams4***\n');
  void repeat(Function<int>(int i) function, {required int times}) {
    //for(var i = 0, i < times, i++) {} //List literals require one type argument or none, but 2 found
    int i = 0;
    do {
      function(times);
    }
    while (i < times);
  }
  //repeat((i) => print(i), times: 100);
}

void optionalPositionalParams() {
  // https://dart.dev/language/functions#optional-positional-parameters

  // 1. Create a variation of function "printFullName" from previous exercise
  // with following positional parameters:
  // - 1 (required) "firstName" - the first name
  // - 2 (required) "lastName" - last name
  // - 3 (optional) "suffix" - по-батькові (optional nullable)
  print('\n***optionalPositionalParams1***\n');
  void printFullName(String firstName, String lastName, [String? suffix]) {
    print("Ім'я: $firstName\n"
        "Прізвище: $lastName\n"
        "По-батькові: $suffix");
  }
  printFullName('Катерина',
      'Нагорна'); //Ім'я: Катерина Прізвище: Нагорна По-батькові: null

  // 1.1 Try to put optional positional "suffix" parameter on the second position in the function declaration. Observe
  // error/result.
  print('\n***optionalPositionalParams1.1***\n');
  // void printFullName1( String firstName, [String? suffix], String lastName) { //Expected to find ')'
  //   print("Ім'я: $firstName\n"
  //       "Прізвище: $lastName\n"
  //       "По-батькові: $suffix");
  // }
  // Optional parameters can only be declared after required parameters.

  // 2. Create a variation of "splitStr" from previous exercises, but make it accept positional parameters:
  // - 1 (required) "str" - string to split
  // - 2 (optional) "separator" - the delimiter to use when splitting the string (optional, defaults to ",")
  // - 3 (optional) "trimWhitespace" - whether to trim whitespace from the substrings (optional, defaults to true)
  // splitStr("hello world", ",");
  // splitStr("hello world", ",", true);   // not a good idea, as it's not clear what "true" means
  print('\n***optionalPositionalParams2***\n');
  // String splitStr(String str, [String separator = ' '], [bool trimWhitespace = true]) { //Expected to find ')'
  //   return trimWhitespace
  //       ? str.split(separator).toString().trim()
  //       : str.split(separator).toString();
  // }
  //There can be only one optional positional operator
}
