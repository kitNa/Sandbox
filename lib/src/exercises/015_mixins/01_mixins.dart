/* Mixins in Dart are a way to reuse code across multiple classes.
They provide a mechanism for adding additional functionality to a class without the need for an
inheritance, this helps to avoid the diamond problem of multiple inheritances.
By using a “mixin” keyword with your “mixin” class, you can easily add the desired functionality
to the superclass or regular class. You can also integrate interfaces or abstract classes with
mixins, making them a top choice among developers.
*** Code reuse: Mixins can be used to reuse code between unrelated classes, while inheritance can only
be* used to reuse code between related classes.
*** Flexibility: Mixins are more flexible than inheritance because they do not require the classes
 to be related.*/

void main() {
  Poodle poodle = Poodle('green', 'brown', 'dog food');
  poodle.breathe();
  print('_______________________________');
  Dolphin dolphin = Dolphin('black', 'gray', 'fish');
  dolphin.breathe();
  print('_______________________________');
  Cat cat = Cat('grey', 'gray', 'fish');
  cat.breathe();
  print('_______________________________');
  Trout trout = Trout(2);
  trout.breathe();
}

abstract interface class Mammal {
  String get getEyeColor;

  String get getFurColor;

  String get getFood;
}

abstract interface class Fish {
  int get numOfFins;

  void breathe();
}

mixin BreathingCreature {
  void breathe() {
    print('This creature develops with the use of oxygen');
  }
}

mixin BreathingWithLungs {
  void breathe() {
    print('This creature breathes with lungs');
  }
}

abstract class AbstractFish with BreathingCreature implements Fish {
  int _numOfFins = 0;

  AbstractFish(int numOfFins) {
    _numOfFins = numOfFins;
  }

  @override
  int get numOfFins => _numOfFins;

  @override
  void breathe() {
    print('Fish breathes with gills');
  }
}

abstract class AbstractMammal with BreathingCreature  implements Mammal {
  final String _eyeColor;
  final String _furColor;
  final String _food;

  AbstractMammal(this._eyeColor, this._furColor, this._food);

  @override
  String get getEyeColor {
    return _eyeColor;
  }

  @override
  String get getFurColor {
    return _furColor;
  }

  @override
  String get getFood {
    return _food;
  }
}

class Trout extends AbstractFish {
  Trout(super.numOfFins);
}

//оскільки і класс і міксин мають однойменний метод toBreathe, на екземплярі
// класу буде викликатися метод класу
class Dolphin extends AbstractMammal implements Fish {
  final int _numOfFins = 2;

  Dolphin(super.eyeColor, super.furColor, super.food);

  @override
  int get numOfFins => _numOfFins;

  @override
  void breathe() {
    print('Dolphins breathe through a spiracles');
  }
}

class Dog extends AbstractMammal {
  Dog(String eyeColor, String furColor, String food)
      : super(eyeColor, furColor, food);

  void iamDog() {
    print('I am a dog. I have a $getEyeColor eye and $getFurColor furo. '
        'I love $getFood.');
  }
}

//оскільки клас підтримує два міксини (один від батьківського классу, а інший
// додано в сигнатурі класу), у яких є метод toBreathe, на екземплярі
// класу буде викликатися метод останнього у списку міксина BreathingWithLungs
class Cat extends AbstractMammal with BreathingWithLungs {
  Cat(String eyeColor, String furColor, String food)
      : super(eyeColor, furColor, food);

  void iamCat() {
    print('I am a cat. I have a $getEyeColor eye and $getFurColor furo.'
        ' I love $getFood.');
  }
}

//оскільки клас не має методу toBreathe, на екземплярі
// класу буде викликатися метод міксина з батьківського класу BreathingCreature
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
