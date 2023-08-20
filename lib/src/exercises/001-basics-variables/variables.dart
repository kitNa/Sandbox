void main() {
  // Dart is optionally typed and strongly typed language. This means that you can declare variables without type
  var implicitCat = Cat();
  // in this case compiler will infer type to be Cat and will allow you to call only methods of Cat
  implicitCat.purr();

  // or you can declare variables with explicit type
  Mammal explicitCat = Cat();
  // compiler will allow you to call only methods of Mammal, trying to call "purr()" will cause compilation error
  // explicitCat.purr(); // compilation error

  // You may omit types for variables, type will be *inferred by compiler*. Inferred type will be the most specific
  // type that is a supertype of all possible values of the variable.
  var inferredMammal;
  inferredMammal = 1.0;
  // check teyp of inferredMammal


  inferredMammal = 'string';
  inferredMammal = Cat();
  inferredMammal.purr(); // compilation error

  assert(false, 'Remove this line and start your work');

  // -----------
  exercise1();
}

void exercise1() {

}


abstract interface class Animal {
  void move();

  void speak();
}

base class Mammal implements Animal {
  @override
  void move() {
    print('Mammal moves');
  }

  @override
  void speak() {
    print('Mammal speaks');
  }
}

base class Fish implements Animal {
  @override
  void move() {
    print('Fish moves');
  }

  @override
  void speak() {
    print('Fish speaks');
  }
}

final class Dog extends Mammal {
  @override
  void speak() {
    print('Dog barks');
  }
}

final class Cat extends Mammal {
  @override
  void speak() {
    print('Cat meows');
  }

  void purr() {
    print('Cat purrs');
  }
}

final class Trout extends Fish {
  @override
  void speak() {
    print('Trout bubbles');
  }
}
