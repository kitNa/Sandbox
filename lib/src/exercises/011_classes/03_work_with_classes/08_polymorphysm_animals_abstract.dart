void main() {
  Mammal poodleAsMammal = Poodle('green', 'brown', 'dog food');
  poodleAsMammal.printAnimal();
  printVoice(poodleAsMammal);
  //poodleAsMammal.iHaveCurls(); //Compile error

  Poodle poodle = Poodle('green', 'brown', 'dog food');
  poodle.iHaveCurls();
  printVoice(poodle);

  Cat cat = Cat('brown', 'grey', 'fish');
  cat.printAnimal();
  printVoice(cat);

  Cow cow = Cow ('brown', 'black', 'grass');
  cow.printAnimal(); //викликається конкретний метод абстрактного класу Mammal
  printVoice(cow);

  // Неможливо створити екземпляр абстрактного класу
  //Mammal mammal = Mammal('green', 'brown', 'milk');
}

void printVoice(Mammal mammal) {
  print(mammal.voice());
}

abstract class Mammal {
  final String _eyeColor;
  final String _furColor;
  final String _food;

  Mammal(this._eyeColor, this._furColor, this._food);

  //абстрактний клас, бо він не має тіла
  String voice();

  String get getEyeColor {
    return _eyeColor;
  }

  String get getFurColor {
    return _furColor;
  }

  String get getFood {
    return _food;
  }

  void printAnimal() {
    print('I am a mammal. I have a $getEyeColor eye and $getFurColor furo.'
        ' I love $getFood.');
  }
}

class Cow extends Mammal {
  Cow (String eyeColor, String furColor, String food)
      : super (eyeColor, furColor, food);

  //перевизначення абстрактного класу э обов'язковим в класах, які його наслідують
  @override
  String voice() {
    return 'mu';
  }

  //перевизначення конкретного класу не обов'язкове
  //@override
  // void printAnimal() {
  //   print('I am a cow. I have a $getEyeColor eye and $getFurColor furo.'
  //       ' I love $getFood.');
  // }
}

class Cat extends Mammal {
  Cat(String eyeColor, String furColor, String food)
      : super(eyeColor, furColor, food);

  @override
  String voice() {
    return 'miy';
  }

  @override
  void printAnimal() {
    print('I am a cat. I have a $getEyeColor eye and $getFurColor furo.'
        ' I love $getFood.');
  }
}

class Dog extends Mammal {
  Dog(String eyeColor, String furColor, String food)
      : super(eyeColor, furColor, food);


  @override
  String voice() {
    return 'barck';
  }

  @override
  void printAnimal() {
    print('I am a dog. I have a $getEyeColor eye and $getFurColor furo. '
        'I love $getFood.');
  }
}

class Poodle extends Dog {
  Poodle(String eyeColor, String furColor, String food)
      : super(eyeColor, furColor, food);
  final String _breed = 'poodle';

  bool iHaveCurls() {
    print('I have curls');
    return true;
  }

  @override
  void printAnimal() {
    print('I am a dog. My breed is $_breed. I have a $getEyeColor eye and '
        '$getFurColor fur. I love $getFood');
  }
}
