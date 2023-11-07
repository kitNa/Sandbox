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
  //1. Create a function with named parameters that will print information about
  // the purchase of any product. Use the following parameters: date, seller, product, price, quantity
//= DateTime(2023, 12, 03)
  void printPurchaseInformation(DateTime date , String seller, String product,
      double price, int quantity) {
    print("дата: $date\n "
        "продавець: $seller\n "
        "товар: $product \n "
        "ціна: $priceгрн\n "
        "кількість: $quantity\n "
        "вартість: ${price * quantity}");
  }

  printPurchaseInformation(date: DateTime.now() , seller: 'Vasyz', product, price, quantity)
}
