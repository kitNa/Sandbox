//возьми кодек (текстовый) и сделай на него декоратор, который текст шифрует и
// расшифровует "шифром Цезаря". Таким образом ты  сможешь с помощью комбинации
// CeasarCrypt(TextCodec()) получить кодек с шифрованием. А потом примени этот
// декоратор на JsonCodec

// IoC - Inversion of Control
// (another well-known name is Dependency Injection)
// IoC is a technique that allows to invert the control of object creation.
// Instead of creating objects by calling "new" operator, we delegate this responsibility to some other code.
// This other code can either be our own manual custom initialization code or it can be a part of the framework.
// (this part is usually called "IoC container"). Or it can be some pre-processors that generate initialization code
// for us.

// In practice: classes should never create other classes themselves. Don't call constructors directly.

// In any case, the main idea is that your "service" objects do not create other objects themselves, but delegate this
// responsibility to some other code. And instead they accept already created objects as constructor parameters (or
// with setters - less preferable).

// object dependency tree:

//   PersonService
//       ||                                   ||
//       ||                                   ||
//  [depends-on]                             [do]
//       ||                                   ||
//       \/                                   \/
//   PersonPersistence                    PersonAudit impl
//       ||             ||                 (no deps)
//       ||             ||
//      [do]           [do]
//       ||             ||
//       \/             \/
//     Codec impl     IOChannel
//       ||             ||
//       ||             ||
//      [do]           [do]
//       ||             ||
//       \/             \/
//     Config          Config

// IMPORTANT: IoC should be applied only to "service" objects. "Service" objects are objects that contain business
// logic. They are not just data containers. They do some work. They have methods that do something. They are not
// just DTOs. They are not just data containers.
// Such "service" objects in 99% of cases should be "effectively singletons". It means that there should be only one
// instance of such object in the whole application. And this instance should be created at the very beginning of the
// application and then passed to all other objects that need it. This is called "singleton" pattern.

// DTO - Data Transfer Object, a class that contains only data and no logic. It's just a data container, "data bag".
// Example: Person, Client, Order, Product, etc. These classes are not "service" objects. They are DTOs.

import 'dart:convert';
import 'dart:io';

void main(List<String> args) {
  Codec codec = TextCodec();
  codec = CaesarCipherCodecDecorator(codec, 1);
  codec = CaesarCipherCodecDecorator(codec, 1);
  codec = CaesarCipherCodecDecorator(codec, 1);
  codec = CaesarCipherCodecDecorator(codec, 3);
  Person person = Person(name: 'Katya', surname: 'Nahorna', phoneNumber: 99967703);
  var encodedPersonListInt = codec.encode(person);
  print('Encoded person info $encodedPersonListInt');
  print('Encoded person info ${String.fromCharCodes(encodedPersonListInt)}');
  Person decodedPerson = codec.decode(encodedPersonListInt);
  print('Decoded person name is ${decodedPerson.name}, '
      'surname is ${decodedPerson.surname}, '
      'phone is ${decodedPerson.phoneNumber}');
}

abstract interface class Codec {
  List<int> encode(Person person);

  Person decode(List<int> personBytes);
}

class Config {
  String codecName;
  String channelName;

  Config(this.codecName, this.channelName);
}

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

class PersonPersistence {
  Codec codec;

  IOChannel channel;

  PersonPersistence(this.codec, this.channel);

  void save(Person person) {
    var personBytes = codec.encode(person);
    channel.save(personBytes);
  }

  Person find(String name) {
    var allBytes = channel.load();
    return allBytes
        .map((personBytes) => codec.decode(personBytes))
        .where((person) => person.name == name)
        .first;
  }
}

// person service
class PersonService {
  final PersonPersistence personPersistence;
  final PersonAudit personAudit;

  PersonService(this.personPersistence, this.personAudit);

  void savePerson(Person person) {
    if (person.name.isEmpty) {
      throw Exception('Name is empty');
    }
    if (person.surname.isEmpty) {
      throw Exception('Surname is empty');
    }
    personPersistence.save(person);
    personAudit.recordPersonSaveEvent(person);
  }

  Person findPerson(String name) {
    var foundPerson = personPersistence.find(name);
    personAudit.recordPersonFindEvent(foundPerson);
    return foundPerson;
  }
}

abstract interface class PersonAudit {
  void recordPersonFindEvent(Person person);

  void recordPersonSaveEvent(Person person);
}

// audit turned off
class NoOpPersonAudit implements PersonAudit {
  @override
  void recordPersonFindEvent(Person person) {
    // do nothing
  }

  @override
  void recordPersonSaveEvent(Person person) {
    // do nothing
  }
}

class IOChannel {
  static final int delimiter = '\n'.codeUnitAt(0);
  String channelName;

  IOChannel(this.channelName);

  void save(List<int> bytes) {
    var file = File(channelName);
    file.writeAsBytesSync(bytes);
  }

  List<List<int>> load() {
    var file = File(channelName);
    var allBytes = file.readAsBytesSync();
    var result = <List<int>>[];
    var currentBytes = <int>[];
    for (var byte in allBytes) {
      if (byte == delimiter) {
        result.add(currentBytes);
        currentBytes = <int>[];
      } else {
        currentBytes.add(byte);
      }
    }
    return result;
  }
}

class JsonCodec implements Codec {
  @override
  Person decode(List<int> personBytes) {
    print("The person was decoded from json");
    return Person(name: 'Katya', surname: 'Nahorna', phoneNumber: 1111111);
  }

  @override
  List<int> encode(Person person) {
    print("The person was encoded to json");
    var jsonStr = """
    {
      "name": "${person.name}",
      "surname": "${person.surname}",
      "phoneNumber": "${person.phoneNumber}"
    }
    """;
    return utf8.encode(jsonStr);
  }
}

class BinaryCodec implements Codec {
  static const int delimiter = 0x00;

  @override
  Person decode(List<int> personBytes) {
    print("The person was decoded from binary");
    return Person(name: 'Katya', surname: 'Nahorna', phoneNumber: 1111111);
  }

  @override
  List<int> encode(Person person) {
    print("The person was encoded to binary");
    var nameBytes = utf8.encode(person.name);
    var surnameBytes = utf8.encode(person.surname);
    var phoneNumberBytes = utf8.encode(person.phoneNumber.toString());
    var personBytes = <int>[];
    personBytes.addAll(nameBytes);
    personBytes.add(delimiter);
    personBytes.addAll(surnameBytes);
    personBytes.add(delimiter);
    personBytes.addAll(phoneNumberBytes);
    return personBytes;
  }
}

class CaesarCipherCodecDecorator implements Codec {
  final Codec _codec;
  final int _shift;

  CaesarCipherCodecDecorator(this._codec, this._shift);

  //раскодировать
  @override
  Person decode(List<int> personBytes) {
    for (var i = 0; i < personBytes.length; i++) {
      int encryptSymbolCode;
      encryptSymbolCode = personBytes[i] - _shift;
      personBytes[i] = encryptSymbolCode;
    }
    Person decodedPerson = _codec.decode(personBytes);

    return Person(
        name: decodedPerson.name,
        surname: decodedPerson.surname,
        phoneNumber: decodedPerson.phoneNumber);
  }

  //закодировать
  @override
  List<int> encode(Person person) {
    var personListInt = _codec.encode(person);
    for (var i = 0; i < personListInt.length; i++) {
      var encodeSymbol = personListInt[i] + _shift;
      personListInt[i] = encodeSymbol;
    }
    return personListInt;
  }
}

class TextCodec implements Codec {
  static const String delimiter = '||';

  @override
  Person decode(List<int> personBytes) {
    // "Katya||Nahorna||1111111"
    var personStr = utf8.decode(personBytes);
    var personData = personStr.split(delimiter);
    print("The person was decoded from text");
    return Person(
        name: personData[0],
        surname: personData[1],
        phoneNumber: int.parse(personData[2]));
  }

  @override
  List<int> encode(Person person) {
    print("The person was encoded to text");
    var personStr = person.name;
    personStr += delimiter;
    personStr += person.surname;
    personStr += delimiter;
    personStr += person.phoneNumber.toString();
    return utf8.encode(personStr);
  }
}

// non-related example of singleton
class DatabaseConnectionPool {
  // ..... it's very expensive to create this object, so we need only one instance for application
}
