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

  // 2. Create a list of 10 elements with animals. Print only those animals that start with vowels. Use for loop
  // with index.
  // var animals = ['cat', .....];
  // for (var i = 0; i < animals.length; i++) { .....

  // 3. Create a list of 10 elements with animals. Print only those animals that start with vowels. Use for-in loop.
  // for (var animal in animals) { .....

  // 4. Do the same as in #3, but use forEach() method.

  // 5. Do the same as in #3, but now insert animals starting with vowels into a new list and print that new list.

  // 6. Do the same as in #3, but now remove animals starting with vowels from the original list and print that list in
  //  the end.
}

void constListExercises() {
  // you can create const lists - lists that cannot be changed (elements cannot be added, removed or changed)
  // var constantList = const [1, 2, 3];

  // 1. Create 2 const lists: one with birds, and another with reptiles. Try to modify them and observe errors.

  // 2. Create a const list of known bad passwords. And create a list of passwords that user enters. Check if entered
  //  is bad or not.
  // To check if element is present in list or not use:
  // list.contains(someElement);
  // https://www.purevpn.com/blog/worst-password-list/
}

void listLengthExercises() {
  // list.length - read-only property to get list length (number of elements)

  // 1. Compare lengths of lists from constListExercises#1 (birds, reptiles). Print the longest list.
}

void listInitializersExercises() {
  // https://dart.dev/guides/libraries/library-tour#lists

  // 1. Create and print a list of movie heroes/characters. Define list as "<String>[]" syntax;

  // 2. Copy constructor - constructor that creates a new list from another list. Copies a list in other words.
  // var newList = List.of(existingList);
  // Copy the list of movie characters from previous exercise, and make all names in new list to be upper case.

  // 3. Make a fixed-size list (non-growable) of bad passwords with copy constructor:
  // var fixedList = List.of(existingList, growable: false);
  // Try to add another bad password to the copied fixed size list, and observe the error.

  // 4. Create two lists: one with 5 birds, and another with 5 reptiles. Create a new list and copy first 3 birds and
  // last 2 reptiles into it. Use copyRange() method:
  // List.copyRange(target, at, source)
}
