// Создать простой DTO (data transfer object, объект без логики, а чисто с
// пропертями и все) класс какой-то, типа User. И несколько кодеков, которые
// можно использовать чтобы этого юзера можно было сохранять и загружать из
// файла. Например json, бинарный, простой текст где каждое поле с новой строки.
// И напиши main, которая вибирает какой кодек использовать в зависимости от
// первого CLI аргумента.

void main(List<String> args) {
  var codecName = args[0];
  late PersonPersistence codec;
  switch (codecName) {
    case ("json"):
      codec = PersonPersistence(JsonCodec());
    case ("bin"):
      codec = PersonPersistence(BinaryCodec());
    case ("txt"):
      codec = PersonPersistence(TextCodec());
  }
  Person person =
      Person(name: 'Katya', surname: 'Nahorna', phoneNumber: 1111111);
  codec.decode(person);
  codec.encode(person);
}

//Strategy interface
abstract interface class Codec {
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
class PersonPersistence {
  Codec concreteStrategy;

  IOChannel channel;

  PersonPersistence(this.concreteStrategy) : channel = IOChannel('channel.txt');

  void encode(Person person) {
    channel.saveToFile(person);
    concreteStrategy.encode(person);
  }

  void decode(Person person) {
    channel.removeFromFile(person);
    concreteStrategy.decode(person);
  }
}

class IOChannel {
  String channelName;

  IOChannel(this.channelName);

  void saveToFile (Person person) {
    print("The person ($person) was save to $channelName");
  }

  void removeFromFile (Person person) {
    print("The person ($person) was remove from $channelName");
  }
}

//concrete strategy 1
class JsonCodec implements Codec {
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
class BinaryCodec implements Codec {
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
class TextCodec implements Codec {
  @override
  void decode(Person person) {
    print('Text decode work with: $person');
  }

  @override
  void encode(Person person) {
    print('Text encode work with: $person');
  }
}
