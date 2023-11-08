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

void namedParams() {
  //1. Create a function with nullable named parameters that will print a person's last
  // name and first name.
  print('\n***namedParams1***\n');
  void printFullName(
      {String? firstName,
        String? lastName}) {
    print("Ім'я: $firstName\n"
        "Прізвище: $lastName");
  }
  printFullName(); //Ім'я: null, Прізвище: null
  printFullName(lastName: 'Radchenko', firstName: 'Lena'); //Ім'я: Lena Прізвище: Radchenko
  printFullName(lastName: 'Radchenko'); //Ім'я: null Прізвище: Radchenko

  // 1.1 Create a function "splitStr" which will split a string into a list of substrings. It should have the following
  // named parameters:
  // - "str" - the string to split (required)
  // - "separator" - the delimiter to use when splitting the string (optional, defaults to ",")
  // - "trimWhitespace" - whether to trim whitespace from the substrings (optional, defaults to true)
  // splitStr(str: "hello,world");       // separator = ",", trimWhitespace = true
  // splitStr(str: "hello world", separator: " "); // trimWhitespace = true
  // splitStr(str: "hello world", trimWhitespace: false); // separator = ","

  //2. Create a function with required  named parameters that will print information about
  // the purchase of any product. Use the following parameters: date, seller, product, price, quantity
  print('\n***namedParams2***\n');
  void printPurchaseInformation(
      {required DateTime date,
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

  // You might want to place positional arguments first, but Dart doesn’t require it. Dart allows named arguments to be
  // placed anywhere in the argument list when it suits your API

  // 3.1 Call function from previous exercise specifying named parameters first.
  // splitStr(separator: " ", "hello world"); // trimWhitespace = true
  // splitStr(separator: " ", trimWhitespace: true, "hello world");
  // and try this too: splitStr(separator: " ", "hello world", trimWhitespace: true);   // NEVER DO THIS in real code

  // 4. Create a "repeat" function which will work as a "for" loop. It should have the following parameters:
  // - "times" - how many times to repeat (required)
  // - positional - void Function<int> the function to call (required),
  // repeat(times: 100, (i) => print(i));   // prints 0, 1, 2, 3, .... 99
}

void optionalPositionalParams() {
  // https://dart.dev/language/functions#optional-positional-parameters

  // 1. Create a variation of function "printFullName" from previous exercise
  // with following positional parameters:
  // - 1 (required) "firstName" - the first name
  // - 2 (required) "lastName" - last name
  // - 3 (optional) "suffix" - по-батькові (optional nullable)

  // 1.1 Try to put optional positional "suffix" parameter on the second position in the function declaration. Observe
  // error/result.

  // 2. Create a variation of "splitStr" from previous exercises, but make it accept positional parameters:
  // - 1 (required) "str" - string to split
  // - 2 (optional) "separator" - the delimiter to use when splitting the string (optional, defaults to ",")
  // - 3 (optional) "trimWhitespace" - whether to trim whitespace from the substrings (optional, defaults to true)
  // splitStr("hello world", ",");
  // splitStr("hello world", ",", true);   // not a good idea, as it's not clear what "true" means
}
