void main() {
  // https://dart.dev/language/collections#lists
  // https://dart.dev/guides/libraries/library-tour#lists

  // List - *ordered* collection of elements, each element has its *position*. List can have duplicates
  //    (elements that are "equal").

  // Compared to other languages, Dart has only lists but does NOT have arrays.
  // array - very light-weight data structure, but has limited functionality
  // list - heavier data structure, but has more functionality

  // [1, 2, 3, 4, 5]
  // [1, 1, 1, 1, 1]
  // [null, 1, null, 2, null]

  var list = [1, 2, 3, 4, 5, 'one', 'two'];
  list.add("new value");

  var emptyList = [];

  // Important feature of lists is type restrictions. So you can specify which types can be stored in lists.
  List<int> intList = [1, 2, 3, 4, 5];
  // intList.add("value"); // -->> compile error

  // Type restrictions are checked at compile time, not at runtime. And compiler also is able to infer list types.
  var anotherIntList = [1, 2, 3, 4, 5];
  print(anotherIntList.runtimeType); // List<int>

  // You can create nested lists (multidimensional lists, matrix)
  List<List<int>> matrix = [
    [1, 2, 3],
    [4, 5, 6]
  ];

  // 3d matrix
  List<List<List<int>>> matrix3d = [
    [
      [1, 2, 3],
      [4, 5, 6]
    ],
    [
      [7, 8, 9],
      [10, 11, 12]
    ]
  ];

  // 4d matrix
  List<List<List<List<int>>>> matrix4d = [
    [
      // young
      [
        // boys
        [1, 2, 3],
        [4, 5, 6]
      ],
      [
        // girls
        [7, 8, 9],
        [10, 11, 12]
      ]
    ],
    [
      // adult
      [
        // male
        [13, 14, 15], // tall
        [16, 17, 18] // short / fat-slim
      ],
      [
        [19, 20, 21],
        [22, 23, 24]
      ]
    ],
    [
      // elder
      [
        [25, 26, 27],
        [28, 29, 30]
      ],
      [
        [31, 32, 33],
        [34, 35, 36]
      ]
    ]
  ];
  var adult = 1;
  var male = 0;
  var short = 1;
  var weight = 2;
  var dateOfBirthOfJohn = matrix4d[adult][male][short][weight];

  // Last comma in lists is allowed, and is practically ignored. This is just a syntax sugar.
  var listWithLastComma = [
    1,
    2,
    3,
    4,
    5, // <<<---- comma here is ignored by Dart compiler
  ];

  // Exercises:
  listIndexAccessExercises();
  constListExercises();
  listLengthExercises();
  listInitializersExercises();
  listMethods();
}

void listIndexAccessExercises() {
  // elements can be accessed by index (position) using square brackets - []
  var list = ['one', 'two', 'three', 'four', 'five'];
  // get element by index from list:
  print(list[0]); // one
  print(list[1]); // two
  // set element by index in list:
  list[1] = 'new value';
  list[4] = list[4].toUpperCase();
  print(list); // [one, new value, three, four, FIVE]

  // 1. Create a printable picture of a house using lists.
  print("\n***listIndexAccessExercises1***\n");

  var roofWidth = 5;
  var wallWidth = roofWidth - 2;
  var rows = [];
  for (var i = 1; i <= roofWidth; i++) {
    // var row = " " * (roofWidth - i) + "* " * i;
    var row = "${' ' * (roofWidth - i)}${'* ' * i}";
    rows.add(row);
  }
  for (var i = 1; i <= wallWidth; i++) {
    // var row = "  " + "* " * wallWidth;
    var row = "  ${'* ' * wallWidth}";
    rows.add(row);
  }
  for (var row in rows) {
    print(row);
  }

  // 2. Create a list of 10 elements with animals. Print only those animals that start with vowels. Use for loop
  // with index.
  // var animals = ['cat', .....];
  // for (var i = 0; i < animals.length; i++) { .....
  print("\n***listIndexAccessExercises2***\n");
  var vowels = ['a', 'e', 'y', 'i', 'u', 'o'];
  var animals = [
    'cat',
    'elephant',
    'jaguar',
    'panda',
    'elk',
    'zebra',
    'bat ',
    'emu',
    'ostrich',
    'puma',
  ];
  bool startsWithVowels(String string) {
    return vowels.contains(string[0]);
  }

  print('Animals that start with vowels:');
  for (var i = 0; i < animals.length; i++) {
    if (startsWithVowels(animals[i])) {
      print(animals);
    }
  }
  // 3. Create a list of 10 elements with animals. Print only those animals that start with vowels. Use for-in loop.
  // for (var animal in animals) { .....
  print("\n***listIndexAccessExercises3***\n");
  print('Animals that start with vowels:');
  for (var animal in animals) {
    if (startsWithVowels(animal)) {
      print(animal);
    }
  }

  // 4. Do the same as in #3, but use forEach() method.
  print("\n***listIndexAccessExercises4***\n");
  print('Animals that start with vowels:');
  animals.forEach((animal) => ({
        vowels.forEach((vowel) => {
              if (animal.startsWith(vowel)) {print(animal)}
            })
      }));

  var listPrinter = (animal) => ({
        vowels.forEach((vowel) => {
              if (animal.startsWith(vowel)) {print(animal)}
            })
      });

  animals.forEach(listPrinter);

  // 5. Do the same as in #3, but now insert animals starting with vowels into a new list and print that new list.
  print("\n***listIndexAccessExercises5.1***\n");
  var animalsStartsWithVowels = [];
  for (var animal in animals) {
    for (var vowel in vowels) {
      if (animal.startsWith(vowel)) {
        animalsStartsWithVowels.add(animal);
      }
    }
  }
  print('Animals that start with vowels:');
  for (var animal in animalsStartsWithVowels) {
    print(animal);
  }

  print("\n***listIndexAccessExercises5.2***\n");
  var animalsStartsWithVowels2 = [];
  animals.forEach((animal) => ({
        if (startsWithVowels(animal)) {animalsStartsWithVowels2.add(animal)}
      }));
  print('Animals that start with vowels:');
  for (var animal in animalsStartsWithVowels2) {
    print(animal);
  }

  // 6. Do the same as in #3, but now remove animals starting with vowels from the original list and print that list in
  //  the end.
  print("\n***listIndexAccessExercises6***\n");
  for (var i = 0; i < animals.length; i++) {
    if (startsWithVowels(animals[i])) {
      animals.remove(animals[i]);
    }
  }
  print('Animals that start with consonants:');
  for (var animal in animals) {
    print(animal);
  }
}

void constListExercises() {
  // you can create const lists - lists that cannot be changed (elements cannot be added, removed or changed)
  // var constantList = const [1, 2, 3];

  // 1. Create 2 const lists: one with birds, and another with reptiles. Try to modify them and observe errors.
  print("\n***constListExercises1***\n");
  const List birds = [
    'blackbird',
    'bluetit',
    'buzzard',
    'crow',
    'cuckoo',
  ];
  const List reptiles = [
    'chameleon',
    'crocodile',
    'lizard',
    'snake',
    'rattlesnake',
  ];
  //reptiles.add('dinosaur'); - Runtime error: Cannot add to an unmodifiable list
  //birds.remove('bluetit'); - Runtime error: Cannot remove from an unmodifiable list
  //birds += reptiles; Compile time error: Constant variables can't be assigned a value.

  // 2. Create a const list of known bad passwords. And create a list of passwords that user enters. Check if entered
  //  is bad or not.
  // To check if element is present in list or not use:
  // list.contains(someElement);
  // https://www.purevpn.com/blog/worst-password-list/
  print("\n***constListExercises1***\n");
  const List badPasswords = [
    '123456',
    '12345678',
    '123456789',
    '12345',
    '1234567',
    'password',
    '1password',
    'abc123',
    'qwerty',
    '111111',
  ];
  var userPasswords = [
    'password',
    'dsdsdsds',
    'qwerty',
  ];
  for (var password in userPasswords) {
    print(
        '\'$password\' - this password is ${badPasswords.contains(password) ? 'bad' : 'good'}');
  }
}

void listLengthExercises() {
  // list.length - read-only property to get list length (number of elements)
  const List birds = [
    'blackbird',
    'bluetit',
    'buzzard',
    'crow',
    'cuckoo',
  ];
  const List reptiles = [
    'chameleon',
    'crocodile',
    'lizard',
    'snake',
    'rattlesnake',
    'rattlesnake',
  ];

  // 1. Compare lengths of lists from constListExercises#1 (birds, reptiles). Print the longest list.
  //print("${birds.length.compareTo(reptiles.length)?"ddd":"dff"}");
  print("\n***listLengthExercises1***\n");
  var compareLength = birds.length.compareTo(reptiles.length);
  print((compareLength == 0)
      ? "The lists have the same length"
      : (compareLength == 1)
          ? "The birds list is longer"
          : (compareLength == -1)
              ? "The reptiles list is longer"
              : throw Exception("Lists cannot be compared"));
  switch (birds.length.compareTo(reptiles.length)) {
    case -1:
      print("The reptiles list is longer");
      break;
    case 0:
      print("The lists have the same length");
      break;
    case 1:
      print("The birds list is longer");
      break;
    default:
      throw Exception("Lists cannot be compared");
  }
}

void listInitializersExercises() {
  // https://dart.dev/guides/libraries/library-tour#lists

  // 1. Create and print a list of movie heroes/characters. Define list as "<String>[]" syntax;
  print("\n***listInitializersExercises1***\n");
  var characters1 = <String>[
    'vinks',
    'pinkie pie',
    'peppa pig',
    'mickey mouse',
    'minnie mouse'
  ];
  List<String> characters = [
    'vinks',
    'pinkie pie',
    'peppa pig',
    'mickey mouse',
    'minnie mouse'
  ];
  characters.forEach((character1) {
    print(character1);
  });

  // 2. Copy constructor - constructor that creates a new list from another list. Copies a list in other words.
  // var newList = List.of(existingList);
  // Copy the list of movie characters from previous exercise, and make all names in new list to be upper case.
  print("\n***listInitializersExercises2***\n");
  var upperCaseCharacters = List.of(characters);

// Не підходить, бо тут модифікується змінна, а не елемент списку
//  for(var character in upperCaseCharacters) {
//    character = character.toUpperCase();
//  }

  for (var i = 0; i < upperCaseCharacters.length; i++) {
    upperCaseCharacters[i] = upperCaseCharacters[i].toUpperCase();
  }

  upperCaseCharacters.forEach((character) => print(character));

  // 3. Make a fixed-size list (non-growable) of bad passwords with copy constructor:
  // var fixedList = List.of(existingList, growable: false);
  // Try to add another bad password to the copied fixed size list, and observe the error.
  print("\n***listInitializersExercises3***\n");
  var badPasswords = [
    '123456',
    '12345678',
    '123456789',
    '12345',
    '1234567',
  ];
  var passwords = List.of(badPasswords, growable: false);
  // passwords.add('value'); - Runtime error: Unsupported operation: Cannot add to a fixed-length list

  // 4. Create two lists: one with 5 birds, and another with 5 reptiles. Create a new list and copy first 3 birds and
  // last 2 reptiles into it. Use copyRange() method:
  // List.copyRange(target, at, source)
  print("\n***listInitializersExercises4***\n");
  var birds = [
    'blackbird',
    'bluetit',
    'buzzard',
    'crow',
    'cuckoo',
  ];
  var reptiles = [
    'chameleon',
    'crocodile',
    'lizard',
    'snake',
    'rattlesnake',
  ];

  var animals = ['animals', 'animals', 'animals', 'animals', 'animals'];
  //діапазон копіювання задається від першого значення включно, виключаючи останній. Тобто, діапазон 0, 3 -
  //це будуть елементи з позицією 0, 1, 2, а діапазон  3,5 - 3, 4.
  List.copyRange(animals, 0, birds, 0, 3);
  List.copyRange(animals, 3, reptiles, 3, 5);
  print(animals);

  // 5. Do same as in #4, but now use "filled" constructor:
  //  List.filled(99, 'broccoli');
  print("\n***listInitializersExercises5***\n");
  animals = List.filled(5, 'animals');
  print(animals);

  // 6. Create a list of 100 elements, where each element is an item position + 100.
  //  For example, [100, 101, 102, 103, 104, 105, 106, 107, 108, 109, ...]
  // Use "generate" constructor:
  // List.generate(100, (pos) => "Hello $pos");
  print("\n***listInitializersExercises6***\n");
  var listOfNumbers = List.generate(100, (pos) => pos + 100);
  print(listOfNumbers);

  // 7. Create unmodifiable copy of list of animals. And try to modify it, observe the error.
  // Use unmodifiable list constructor:
  // var unmodifiableList = List.unmodifiable(existingList);
  print("\n***listInitializersExercises7***\n");
  var unmodifiableAnimalsList = List.unmodifiable(animals);
  //unmodifiableAnimalsList.add("new animal"); -  Runtime error: Cannot add to an unmodifiable list
  unmodifiableAnimalsList += birds;
  print(unmodifiableAnimalsList);
  unmodifiableAnimalsList.add("new animal");
  print(unmodifiableAnimalsList);
}

void listMethods() {
  // https://dart.dev/guides/libraries/library-tour#lists

  // 1. Create a list of numbers from 1 to 10 (use "List.generate" constructor).
  // Reverse the list with ".reversed" property to reverse elements.
  print("\n***listMethods1***\n");
  var listOfNumbers = List.generate(10, (index) => index + 1);
  var reversedList = listOfNumbers.reversed;
  print(reversedList);

  // 2. Given a list of elements ['one', 'two', 'three', 'four', 'five'].
  //  Using "indexed" and "forEach" print elements with their positions:
  //  0: one
  //  1: two
  //  and so on.
  // list.indexed.forEach((record) => print("index=${record.$1}, value=${record.$2}"));
  print("\n***listMethods2***\n");
  var stringListOfNumbers = [
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten'
  ];
  stringListOfNumbers.indexed
      .forEach((record) => print("${record.$1 + 1} : ${record.$2}"));

  // 3. Use list of number strings from #2. Print first list element and last one. \
  // Use "first" and "last" properties.
  print("\n***listMethods3***\n");
  print("First list element is: ${stringListOfNumbers.first}"
      "\nLast list element is: ${stringListOfNumbers.last}");

  // 4. Create myChildren list with single "Margo" item there. Get "Margo" into
  // a String variable from the list using "single" property.
  // var singleString = ['one'].single;
  print("\n***listMethods4***\n");
  var myChildren = ['Margo'];
  var singleString = myChildren.single;
  print(singleString);
}
