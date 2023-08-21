void main() {
  // ------------------------- Optional and Explicit typing -------------------------
  // Dart is optionally typed and strongly typed language. This means that you can declare variables without type
  var implicitCat = Cat();
  // in this case compiler will infer type to be Cat and will allow you to call only methods of Cat
  implicitCat.purr();

  // or you can declare variables with explicit type
  Mammal explicitMammal = Cat();
  // here compiler will allow you to call only methods of Mammal, trying to call "purr()" will cause compilation error
  // explicitCat.purr(); // compilation error
  // even though the real object is Cat and actually has "purr()" method

  // You may omit types for variables, type will be inferred by *compiler*. Type inference for untyped variables seems
  // to be very simple - type of the initial value is used.
  var untyped = Cat();
  untyped.purr();
  // untyped = Dog(); // compilation error, it won't try to guess closest common ancestor and assume that "untyped" may
  // be Mammal to make this code work, you have to declare "untyped" as Mammal explicitly for such setup

  // ------------------------- Dynamic typing -------------------------
  // Dart behaves as statically typed language by default, but can become dynamic if you use "dynamic" type
  dynamic dynamicVar = Cat();
  dynamicVar.purr();
  dynamicVar = Dog(); // no compilation error, you can reassign "dynamic" variables to any type
  dynamicVar.speak(); // --> Dog barks
  // dynamicVar.purr();
  // dynamicVar.bark();
  // dynamicVar.quack();
  // dynamicVar.anyRandomMethod();
  // ^^^ compiler will allow invocations of any methods on "dynamic" variable. Though, any of those invocations will
  // fail in runtime (when you run your application) with NoSuchMethodError if the real object doesn't have such method

  // So there's compile time type and runtime type. Compile time type is used by compiler to check if you're calling
  // correct methods on variables. Runtime type takes effect when you run your application.
  // Runtime type can be accessed via "runtimeType" property
  print("dynamicVar.runtimeType=${dynamicVar.runtimeType}"); // --> Dog
  // or can be checked via "is" operator (or "is!" for negation)
  if (dynamicVar is Dog) {
    print('dynamicVar is Dog');
  }
  if (dynamicVar is! Cat) {
    print('dynamicVar is not Cat');
  }

  // NOTE: if you don't specify initial value for an untyped variable, the type is "dynamic"
  var untyped2; // equals to "dynamic untyped2;"
  untyped2 = Cat();
  untyped2.purr();
  untyped2 = Trout();
  // untyped2.purr(); // NO compilation error here, but the call will fail in runtime with NoSuchMethodError

  // -----------
  variablesDeclarations();
  nullSafety();
  defaultValue();
  lateVariables();
  constAndFinalVariables();
}

void variablesDeclarations() {
  // 1. Declare three untyped variables with your favorite animals (string literals) (use "var")
  //    and then declare three explicitly typed String variables with your favorite names (like `String name = '...'`)
  //    print animal+name combinations (concat strings with "+" operator)

  // 2. Create a Trout object and assign it to a variable of type "dynamic"
  //    then try to call "purr()" method on it - observe the result, note how compiler doesn't complain about anything
  //    trouts don't purr, right?
  //    then reassign the same variable to a new Cat object and call "purr()" again - observe the result
}

void nullSafety() {
  // Compiler prevents you from calling potential nulls, and it requires you to initialize non-nulls.

  // 1. Try to create a String variable "myHeart" and assign it to null. Observe the error. Dart doesn't seem to like
  //    heartless engineers, does it? Now init it with "full of love to Dart" literal. Dart will like it for sure.
  //    Print it.

  // 2. Now create nullable string variable "zombieHeart" and assign it to null. Print it and observe the result. Dart
  //    doesn't seem to like zombies either, so it's ok with heartless zombies.

  // 3. Now create a Car class with at least 5 parts (String properties). Mark all the non-vital parts as
  //    nullable (parts without which the car can move). For example, engine - vital and non-nullable, front
  //    doors - non-vital and nullable. Create some car objects with different set of parts and print them.

  // 4. Create a car object with some non-vital parts missing (null values). Print *hashCode* and *runtimeType* of
  //    each car part, including nulls. Observe result.
  //    Now print *length* of each car part, including nulls. Observe the result error.
  //    example class:
  //    class Computer {
  //      String cpu;
  //      String ram;
  //      String hdd;
  //      String? monitor;  // <<--- this is nullable
  //      String? mouse;    // <<--- this is nullable
  //
  //      Computer(this.cpu, this.ram, this.hdd, this.monitor, this.mouse);
  //    }
}

void defaultValue() {
  // 1. Print out nullable uninitialized variables:
  //   - zombieHeart      (string obj)
  //   - car              (custom obj)
  //   - salaryOfMyDream  (int)
  //   - var weird = 7/8; (double)
  //   - dynamic myTrout; (dynamic)
}

void lateVariables() {
  // 1. Create "late" variable "salaryOfMyDream". And try to print it before initialization. Observe the error. Is it
  //    runtime or compile time error?

  // 2. Create "late" String variable "myBankHistory" which is lazily initialized with "getBankHistory()". Run the app.
  //    Then print bank history variable and observe the output.
}

void constAndFinalVariables() {
  // Const and final variables can be set only once. You can't change them after.
  // The difference is that const variables *values* must be known at compile time (without running your application),
  // while final variables can be set at runtime (when you run your application).

  // In other words, values for const variables must be literals or const variables themselves. Values should be there
  // in the source code itself.

  // Values for final variables may come from user, from database, from file, etc.

  // Values that can't be changed after creation/initialization are called "immutable".

  // NOTE: It's not clear to me yet what are exactly the boundaries of using const. It seems that you can use const for
  // objects too (https://dart.dev/effective-dart/usage#dont-use-const-redundantly), but I'm not sure how it works.
  // So for this exercise we'll use const only for simple types - int, double and Strings too).

  // 1. Create const "salaryOfMyDream" with 100 billions value. And try to change it to zero. Observe the error.

  // 2. Create const variable "myName" with your name, and try to change it to "myName + ' is the best'". Observe the
  //    error.

  // 3. Create final Animal variable "myCat" and assign it to a new Cat object. Then try to reassign it to a new Dog.
  //    Observe the error. Then try to reassign it to another new Cat object. Observe the error. Your cat is with you
  //    forever, you can't change it when it's final.
}


// ---------------------------------------------------------------------------------------------------------------------

String getBankHistory(String clientId) {
  print('Gathering LOTS of information from the database ....');
  return 'Bank history for $clientId - you have 100 billions on your account';
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
