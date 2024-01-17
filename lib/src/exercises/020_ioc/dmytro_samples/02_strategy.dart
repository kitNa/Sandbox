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
  // 1 - initialize - create all the objects in proper order and "inject" them as constructor parameters

  // create config object - this may be a complex task, values for config may be composed from many different sources
  // for simplicity we will hardcode config values here
  var config = Config('json', 'channel.txt');

  var codecName = args[0];
  late Codec codec;
  // 1.1 - create concrete objects that do not depend on anything
  switch (codecName) {
    case ("json"):
      codec = JsonCodec();
    case ("bin"):
      codec = BinaryCodec();
    case ("txt"):
      codec = TextCodec();
  }
  var channelName = 'channel.txt'; // in real life this would be read from config
  var channel = IOChannel(channelName);
  var personAudit = NoOpPersonAudit();

  // 1.2 - create objects that depend on 1.1 objects
  var personPersistence = PersonPersistence(codec, channel);

  // 1.3 - create objects that depend on 1.2 objects
  // .... create object that depends on "personPersistence" object
  // var personService = PersonService(personPersistence);
  var personService = PersonService(personPersistence, personAudit);

  // There are frameworks (dependency injection frameworks) that do this initialization for you. They are called
  // "IoC containers".


  // ------------------------------------------------------------------------

  // 2 - work
  Person person = Person(name: 'Katya', surname: 'Nahorna', phoneNumber: 1111111);
  personService.savePerson(person);
  var foundPerson = personService.findPerson('Katya');
  print(foundPerson);
}

//Strategy interface
abstract interface class Codec {
  List<int> encode(Person person);

  Person decode(List<int> personBytes);
}

// Even though this looks like DTO, this object is a singleton, and is *global* for the whole applicaiton. It will
// be created only once and populated everywhere.
class Config {
  String codecName;
  String channelName;

  Config(this.codecName, this.channelName);
}

//Object
// This object is a DTO, it's not a "service" object. It's not global. Instances of this class will be created
// many times. Hence, this class is not a subject to IoC. Just create it with constructor.
class Person {
  String name;
  String surname;
  int phoneNumber;

  Person({required this.name, required this.surname, required this.phoneNumber});

  @override
  toString() {
    return '$name $surname - $phoneNumber';
  }
}

//strategy context
class PersonPersistence {
  Codec codec; // strategy

  IOChannel channel;

  PersonPersistence(this.codec, this.channel);

  /* EXAMPLE OF BAD DECISION
  We could allow PersonPersistence to create Codec and IOChannel objects itself.
  But this approach has disadvantages:
   - logic of choosing concrete impl (json or binary codec) does not belong to PersonPersistence
   - decision of *how many instances* of Codec and IOChannel to create does not belong to PersonPersistence
   - if other classes also need to create Codec and IOChannel, we will have code duplication

  PersonPersistence(config) : this.codec = buildConcreteStrategy(config), this.channel = buildChannel(config);

  Codec buildConcreteStrategy(Config config) {
    switch (config.codecName) {
      case ("json"):
        return JsonCodec();
      case ("bin"):
        return BinaryCodec();
      case ("txt"):
        return TextCodec();
    }
  }

  IOChannel buildChannel(Config config) {
    var channelName = config.channelName;
    return IOChannel(channelName);
  }
   */
  
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

  // final PersonAudit personAudit = PersonAuditImp1();  BAD - IoC violation, PersonService should not create PersonAuditImp1
  //                                                           it's not responsible for choosing concrete implementation of PersonAudit
  //                                                           calling code should be responsible for this
  // CORRECTED: PersonService only stores reference to PersonAudit, and it is provided as constructor parameter
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

//concrete strategy 1
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

//concrete strategy 2
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

//concrete strategy 3
class TextCodec implements Codec {
  static const String delimiter = '||';

  @override
  Person decode(List<int> personBytes) {
    // "Katya||Nahorna||1111111"
    var personStr = utf8.decode(personBytes);
    var personData = personStr.split(delimiter);
    print("The person was decoded from text");
    return Person(name: personData[0], surname: personData[1], phoneNumber: int.parse(personData[2]));
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
