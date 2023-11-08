import 'dart:ffi';

void main() {
  // https://dart.dev/language/functions

  // TODO: create exercises

  // 1. Named params

  // 2. Combine named + positional params

  // 3. Required named params

  // 4. Optional positional params

  namedParams();
}

void namedParams() {
  //1. Create a function with named parameters that will print a person's last
  // name and first name. By default, fill in the data with your own name.
  print('\n***namedParams1***\n');
  void printFullName(
      {String firstName = 'Katya',
        String lastName = 'Nahorna'}) {
    print("Ім'я: $firstName\n"
        "Прізвище: $lastName");
  }
  printFullName(); //Ім'я: Katya, Прізвище: Nahorna
  printFullName(lastName: 'Radchenko', firstName: 'Lena'); //Ім'я: Lena Прізвище: Radchenko
  printFullName(lastName: 'Radchenko'); //Ім'я: Katya Прізвище: Radchenko

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
}
