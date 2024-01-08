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

  // Так зробити можна, але це погано з точки зору доменної області
  //Mammal mammal = Mammal('', '', '');
  Mammal mammal = Mammal('green', 'brown', 'milk');
  mammal.printAnimal();
  printVoice(mammal);
}

void printVoice(Mammal mammal) {
  print(mammal.voice());
}

class Mammal {
  final String _eyeColor;
  final String _furColor;
  final String _food;

  Mammal(this._eyeColor, this._furColor, this._food);

  String voice() {
    return 'undefined';
  }

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
