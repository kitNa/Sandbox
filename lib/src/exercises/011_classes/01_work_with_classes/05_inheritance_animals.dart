void main() {
  Poodle poodle = Poodle('green', 'brown', 'dog food');
  poodle.iamDog();
  // Так зробити можна, але це погано з точки зору доменної області
  Mammal mammal = Mammal('', '', '');
}

class Mammal {
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
