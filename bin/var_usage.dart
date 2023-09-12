import 'dart:io';
//Peculiarities of the behavior of the variable with the keyword VAR
void main() {
  //1)Using the VAR keyword, add a meaningful variable name
  void printUserData() {
    print('Enter your nick name:');
    var userNickName = stdin.readLineSync();
    print('Number is ${userNickName.runtimeType} with value $userNickName');
    print('Enter your name:');
    var userName =stdin.readLineSync();
    print('User nick name is ${userNickName}\nUser name is with value ${userName}');
  }
   //printUserData();

  //2)Assigning different numerical types to VAR variable
  void printNumbersType() {
    var number; // this is inferred as null
    number = 22;   // this is inferred as int
    print('Number is ${number.runtimeType} with value $number');
    number = 22.4;    // this is inferred as double
    print('Number is ${number.runtimeType} with value $number');
    number = 22.44455677898909000000; // this is inferred as double
    print('Number is ${number.runtimeType} with value $number');
  }
 // printNumbersType();

  //3)Creating a VAR variable with an array of different types elements
  void printListType() {
    var exampleArrayObjects =  [1, 'string', 3, 4, 5]; // inferred as array of object
    exampleArrayObjects[0] = 2.4;
    exampleArrayObjects[1] = "katya";
    exampleArrayObjects[2] = "hello";
    print('Number is ${exampleArrayObjects.runtimeType} with value $exampleArrayObjects');
    exampleArrayObjects = [1, 2, 3, 4, 5]; // inferred as array of object
    print('Number is ${exampleArrayObjects.runtimeType} with value $exampleArrayObjects');


    var exampleArrayInt =  [1, 2, 3, 4, 5]; // inferred as array of int
    //exampleArrayInt[0] = 2.4; A value of type 'double' can't be assigned to a variable of type 'int'.
    //exampleArrayInt[1] = "katya"; A value of type 'String' can't be assigned to a variable of type 'int'.
    print('Number is ${exampleArrayInt.runtimeType} with value $exampleArrayObjects');
    //exampleArrayInt = [1, 'jagh', 3, 4, 5]; The element type 'String' can't be assigned to the exampleArrayObjects type 'int'.
  }
  //printListType();

  //4)With VAR, you can declare variables of the same type at once
  void printGreeting() {
    var type = "hello,", characteristic = " dear", name = " Katya";
    print(type + characteristic + name);
  }
  //printGreeting();

  //5)The VAR type is convenient to use in ternary operators
  void printMonroeInfo() {
    print('Hello! This is information about Marilyn Monroe!');
    print('If you are interested in finding out her year of birth - press y.'
        '\nIf you are interested in finding out her real name - press n.');
    var pointer = stdin.readLineSync();
    var condition;

    if (pointer == 'y') {
      condition = true;
      }
    if (pointer == 'n') {
      condition = false;
    }

    var result = condition? 1926 : 'Norma Jean Mortenson-Baker';
    print(result);
  }
  //printMonroeInfo();

  //6)Var cannot be used as the return type of a method
  //var countItems(Order order, long timestamp) {} - Can't have modifier 'var' here.
  int countCost(var price, var number) {
    var result = price*number;
    return result;
  }
  //print(countCost(10, 15));

  //7)Var can be used as an input parameter
  void printCost(var price, var number) {
    if (price.runtimeType == int && number.runtimeType == int) {
      print('The cost is ${price*number}');
      }
    else {
      print('You have entered incorrect data!');
      }
  }
  //printCost(10, 15);
  //printCost(10, 'ff');

  //8)Var cannot be used with the final keyword
  //void discount(int price) {
  //  final var limit = 2000; - Members can't be declared to be both 'final' and 'var'
  //  .....}

  //9)The variable var can be assigned a null value
  void printNullMessage() {
    var message = null;
    print(message);
  }
  //printNullMessage();
}
