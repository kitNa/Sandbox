// Создать простой DTO (data transfer object, объект без логики, а чисто с
// пропертями и все) класс какой-то, типа User. И несколько кодеков, которые
// можно использовать чтобы этого юзера можно было сохранять и загружать из
// файла. Например json, бинарный, простой текст где каждое поле с новой строки.
// И напиши main, которая вибирает какой кодек использовать в зависимости от
// первого CLI аргумента.

void main(List<String> args) {
  var codecName = args[0];
  late Codec codec;
  switch (codecName) {
    case ("json"):
      codec = Codec(JsonCodec());
    case ("bin"):
      codec = Codec(BinaryCodec());
    case ("txt"):
      codec = Codec(TextCodec());
  }
  Person person =
      Person(name: 'Katya', surname: 'Nahorna', phoneNumber: 1111111);
  codec.decode(person);
  codec.encode(person);
}

//Strategy interface
abstract interface class StrategyInterface {
  void encode(Person person);

  void decode(Person person);
}

//Object
class Person {
  String name;
  String surname;
  int phoneNumber;

  Person(
      {required this.name, required this.surname, required this.phoneNumber});

  @override
  toString() {
    return '$name $surname - $phoneNumber';
  }
}

//strategy context
class Codec implements StrategyInterface {
  StrategyInterface concreteStrategy;

  Codec(this.concreteStrategy);

  @override
  void encode(Person person) {
    concreteStrategy.encode(person);
  }

  @override
  void decode(Person person) {
    concreteStrategy.decode(person);
  }
}

//concrete strategy 1
class JsonCodec implements StrategyInterface {
  @override
  void decode(Person person) {
    print('Json decode work with: $person');
  }

  @override
  void encode(Person person) {
    print('Json encode work with: $person');
  }
}

//concrete strategy 2
class BinaryCodec implements StrategyInterface {
  @override
  void decode(Person person) {
    print('Binary decode work with: $person');
  }

  @override
  void encode(Person person) {
    print('Binary encode work with: $person');
  }
}

//concrete strategy 3
class TextCodec implements StrategyInterface {
  @override
  void decode(Person person) {
    print('Text decode work with: $person');
  }

  @override
  void encode(Person person) {
    print('Text encode work with: $person');
  }
}
