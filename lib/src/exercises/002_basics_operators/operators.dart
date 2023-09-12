import 'dart:math';
import 'dart:io';

void main() {
  // https://dart.dev/language/operators

  arithmeticOperators();
  logicalOperators();
}

void arithmeticOperators() {
  // 1. You bought coffee for 3.65 and cake for 4.35. How much did you spend?
  print('***arithmeticOperators1***');
  var priceCoffee = 3.65;
  var priceCake = 4.35;
  print('I spend ${priceCake + priceCoffee}');

  // 2. You have 50.0 and you want to buy 3 coffees for 3.65 each. How much money do you have left?
  print('***arithmeticOperators2***');
  var cash = 50;
  print('I have left ${cash - 3*priceCoffee}');

  // 3. You have 100$. You want to split it between your family members. Your kid gets 20%, your wife 30% and you keep
  //    the rest. How much money does each of you get?
  print('***arithmeticOperators3***');
  cash = 100;
  var kidMany = cash*0.2;
  var myMany = cash*0.3;
  var husbandMany = cash - kidMany - myMany;
  print('My kid gets ${kidMany} \$, I get ${myMany}\$ and my husband gets ${husbandMany}\$');

  // 4. Find all numbers between 1 and 20 that are divisible by 3 and 2. (use % operator - remainder of the division)
  print('***arithmeticOperators4***');
  for(int i = 2; i<20; i++){
    if(i%2 == 0 && i%3 == 0){
      print(i);
    }
  }

  // 5. Now count how many numbers between 1 and 20 are divisible by 3 and 2. (use counter variable and ++ operator)
  print('***arithmeticOperators5**');
  var counter = 0;
  for(int i = 2; i<20; i++){
    if(i%2 == 0 || i%3 == 0){
      counter++;
    }
  }
  print(counter);

  // 6. Create a small game where you roll a dice (1-6) and move your player on a board from 0 to 100 position.
  //    If you roll a number divisible by 3, you go one step back (use -- operator). Otherwise you go one step forward
  //    (use ++ operator).
  //    For dice roll you can use this random number generator snippet:
  //    var rnd = Random();
  //    var dice = rnd.nextInt(6) + 1;
  print('***arithmeticOperators6**');
  counter = 0;
  var countOfSteps = 0;
  while(counter <= 100){
    countOfSteps ++;
    var rnd = Random();
    var dice = rnd.nextInt(6) + 1;
    if(dice == 3 && countOfSteps >= 1){
      counter--;
    }
    else if(dice == 3 && countOfSteps < 1){
      counter = 0;
    }
    else {
      counter++;
    }
  }
  print(countOfSteps);

  // 7. Find sum of all numbers between 1 and 100 that are divisible by 3 and 2. (use += operator)
  print('***arithmeticOperators7**');
  var sum = 0;
  for(int i = 2; i<100; i++){
    if(i%2 == 0 && i%3 == 0){
      sum += i;
    }
  }
  print(sum);

  // 8. Create a function that accepts String and returns same string or "UNDEFINED" if string is null.
  //    (use ??= operator)
  print('***arithmeticOperators8**');
  void printString(String? string){
    string ??= "UNDEFINED";
    print(string);
  }
  printString('Hallo!');
  printString(null);
}

void logicalOperators() {
  // TODO: create exercises for logical operators
}
