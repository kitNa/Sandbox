void main() {

  // can not instantiate interface
  // var mammal = Mammal();
  // mammal.feedBabiesWithMilk();

  print('Cow:');
  var cow = Cow();
  var cowBaby = Cow();
  printMammal(cow, cowBaby);
  cow.walk();

  print('');
  print('Cat:');
  var cat = Cat();
  var catBaby = Cat();
  printMammal(cat, catBaby);
  cat.walk();

  print('');
  print('Platypus:');
  var platypus = Platypus();
  var platypusBaby = Platypus();
  printMammal(platypus, platypusBaby);
  platypus.walk();
  platypus.swim();
}

void printMammal(Mammal m, Mammal baby) {
  print('milk amount: ${m.milkAmount}');
  m.feedBaby(baby);
  m.voice();
}


abstract interface class Flying {
  void fly();
}

abstract interface class Swimming {
  void swim();
}

abstract interface class Walking {
  void walk();
}

abstract interface class Animal {
  void feedBaby(Animal baby);
  void voice();
}

abstract interface class Mammal implements Animal {
  int get milkAmount;
}

abstract interface class WalkingMammal implements Mammal, Walking {

  // receives SIGNATURES from Mammal:
  // int get milkAmount;

  // + receives all SIGNATURES from all Mammal parents:
  // Animal:
  //  void feedBaby(Animal baby);
  //  void voice();
  // Object:
  //  String toString();
  //  bool operator ==(Object other);
  //  int get hashCode;
}

// DON'T DO THIS: don't "extend" (pull signatures and bodies) from interface
//  use "implements" instead - implements Mammal, Flying
abstract interface class FlyingMammal extends Mammal implements Flying {

  // receives all BODIES and all SIGNATURES from Mammal:
  // + all bodies and signatures from all Mammal parents:
}

abstract interface class SwimmingMammal implements Mammal, Swimming {
}


// -----------------------------------------------

abstract class UndergroundMammal implements Mammal {
  @override
  void feedBaby(Animal baby) {
    print('underground mammal feeds baby with milk: amount=$milkAmount, baby=$baby');
  }

  @override
  void voice() {
    print('underground mammal voice');
  }
}


abstract class GenericMammal implements Mammal {

  @override
  void feedBaby(Animal baby) {
    print('mammal feeds baby with milk: amount=$milkAmount, baby=$baby');
  }
}

class Cow extends GenericMammal implements WalkingMammal {

  @override
  int get milkAmount => 100;

  @override
  void voice() {
    print('moo-moo');
  }

  @override
  void walk() {
    print('cow walks');
  }
}

class Dog extends GenericMammal implements WalkingMammal {

  @override
  int milkAmount = 13;

  @override
  void voice() {
    print('woof-woof');
  }

  @override
  void walk() {
    print('dog walks');
  }
}

class Cat extends GenericMammal implements WalkingMammal {

  @override
  int milkAmount = 7;

  @override
  void voice() {
    print('meow-meow');
  }

  @override
  void walk() {
    print('cat walks');
  }
}

class Platypus extends GenericMammal implements WalkingMammal, SwimmingMammal {

  @override
  int milkAmount = 0;

  @override
  void voice() {
    print('quack-quack');
  }

  @override
  void walk() {
    print('platypus walks');
  }

  @override
  void swim() {
    print('platypus swims');
  }
}
