/* Mixins in Dart are a way to reuse code across multiple classes.
They provide a mechanism for adding additional functionality to a class without the need for an
inheritance, this helps to avoid the diamond problem of multiple inheritances.
By using a “mixin” keyword with your “mixin” class, you can easily add the desired functionality
to the superclass or regular class. You can also integrate interfaces or abstract classes with
mixins, making them a top choice among developers.
*** Compile time: Mixins are compiled at runtime, which can make debugging more difficult. Inheritance
is compiled at compile time, which can make debugging easier.
*** Code reuse: Mixins can be used to reuse code between unrelated classes, while inheritance can only
be* used to reuse code between related classes.
*** Flexibility: Mixins are more flexible than inheritance because they do not require the classes
 to be related.*/

void main() {
  Poodle poodle = Poodle('green', 'brown', 'dog food');
  poodle.toBreath();
  Fish fish = Fish();
  fish.toBreath();
}

mixin class BreathingCreature {
  void toBreath() {
    print('This creature develops with the use of oxygen');
  }
}

class Fish with BreathingCreature {
}

abstract class Mammal with BreathingCreature {
  final String _eyeColor;
  final String _furColor;
  final String _food;

  Mammal(this._eyeColor, this._furColor, this._food);

  String get getEyeColor {
    return _eyeColor;
  }

  String get getFurColor {
    return _furColor;
  }

  String get getFood {
    return _food;
  }
}

class Cat extends Mammal {
  Cat(String eyeColor, String furColor, String food)
      : super(eyeColor, furColor, food);

  void iamCat() {
    print('I am a cat. I have a $getEyeColor eye and $getFurColor furo.'
        ' I love $getFood.');
  }
}

class Dog extends Mammal {
  Dog(String eyeColor, String furColor, String food)
      : super(eyeColor, furColor, food);

  void iamDog() {
    print('I am a dog. I have a $getEyeColor eye and $getFurColor furo. '
        'I love $getFood.');
  }
}

class Poodle extends Dog {
  Poodle(String eyeColor, String furColor, String food)
      : super(eyeColor, furColor, food);
  final String _breed = 'poodle';

  @override
  void iamDog() {
    print('I am a dog. My breed is $_breed. I have a $getEyeColor eye and '
        '$getFurColor fur. I love $getFood');
  }
}
