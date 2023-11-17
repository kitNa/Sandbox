void main() {
  var dog = Dog();
  // inherited members
  dog.feedBabiesWithMilk();
  print("dog milk : ${dog.milkAmount}");
  // individual members
  dog.bark();
  // dog.meow(); // error - dog doesn't have meow method


  var cat = Cat();
  // inherited members
  cat.feedBabiesWithMilk();
  print("cat milk : ${cat.milkAmount}");
  // individual members
  cat.meow();
  // cat.bark(); // error - cat doesn't have bark method
}


class Mammal {
  int milkAmount = 0;

  void feedBabiesWithMilk() {
    print('mammal feeds its babies with milk');
  }
}

class Dog extends Mammal {
  void bark() {
    print('woof-woof');
  }
}

class Cat extends Mammal {
  void meow() {
    print('meow-meow');
  }
}
