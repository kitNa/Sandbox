import 'package:http/http.dart' as http;

Future<void> main() async {
  // https://dart.dev/language/collections#maps
  // https://dart.dev/guides/libraries/library-tour#maps

  // additional collections libraries:
  //  - collection - https://pub.dev/packages/collection
  //  - quiver     - https://pub.dev/packages/quiver

  // Maps are key-value collections. Maps are unordered (order is not guaranteed like in "set").
  mapOperators();
  await mapMethods();
  mapViews();
}

void mapOperators() {
  // 1. Define map with "name"=>age pairs. And print it. Use map literal " {'name': age} " syntax.
  print('\n***mapOperators1***\n');
  var myFamily = {'Katya': 32, 'Sasha': 42, 'Margosha': 5};
  print(myFamily);

  // 2. Now define the same map using Map constructor - "Map<String, int>()". And fill map with values
  // using "[]=" operator.
  // var parts = Map<String, String>();
  // parts['engine'] = 'good';
  // parts['door'] = 'bad';
  print('\n***mapOperators2***\n');
  var family = Map<String, int>();
  family['Katya'] = 32;
  family['Sasha'] = 42;
  family['Margosha'] = 5;

  // 3. Print age of "John" (any other name that exists in map) from the map. Use "[]" operator.
  // print(parts['engine']);
  print('\n***mapOperators3***\n');
  print('Katya is ${family['Katya']} years old');

  // 4. Define constant map of "first name"=>"last name" pairs. Try to add more elements to it and observe error.
  // final constantMap = const {
  //   2: 'helium',
  //   10: 'neon',
  //   18: 'argon',
  // };
  print('\n***mapOperators4***\n');
  final writers = const {
    'David': 'Dabydeen',
    'Charlotte': 'Dacre',
    'Roald': 'Dahl',
    'William': 'Dakins',
    'Andrew': 'Dalby'
  };
  //writers['Monica'] = 'Dickens'; //Runtime exception: Unsupported operation: Cannot modify unmodifiable map
}

Future<void> mapMethods() async {
  final writers = const {
    'David': 'Dabydeen',
    'Charlotte': 'Dacre',
    'Roald': 'Dahl',
    'William': 'Dakins',
    'Andrew': 'Dalby'
  };

  // 1. Use map from previous exercise. Print length of the map.
  print('\n***mapMethods1***\n');
  print(writers.length);

  // 2. Copy map from previous exercise into "namesCopy" variable. Use "Map.of()" copy constructor.
  print('\n***mapMethods2***\n');
  var writersCopy = Map.of(writers);
  writersCopy['Monica'] = 'Dickens';
  print(writersCopy);

  // 3. Check if "John" exists in "namesCopy" map. Use "containsKey()" method.
  print('\n***mapMethods3***\n');
  print(
      'Is William in writersCopy keys? ${writersCopy.containsKey('William')}');
  print(
      'Is Dacre in writersCopy values? ${writersCopy.containsValue('Dacre')}');

  // 4. Remove "John" from "namesCopy" map. Use "remove('key')" method. Check again with "containsKey()" method.
  print('\n***mapMethods4***\n');
  writersCopy.remove('William');
  print(
      'Is William in writersCopy keys? ${writersCopy.containsKey('William')}');
  print(
      'Is Dacre in writersCopy values? ${writersCopy.containsValue('Dakins')}');

  // 5.1 Crate map of [Book => Author] pairs with few entries. Add new entry to
  // the map if map doesn't contain it. Use following approach:
  // if (!map.containsKey(key)) {
  //   map[key] = 123;
  // }
  print('\n***mapMethods5.1***\n');
  var books = {
    "Matt Haig": "The Midnight Library",
    "V.E. Schwab": "The Invisible Life of Addie LaRue",
    "Taylor Jenkins Reid": "The Seven Husbands of Evelyn Hugo",
    "F. Scott Fitzgerald": "The Great Gatsby",
  };
  if (!books.containsKey("Harper Lee")) {
    books["Harper Lee"] = "To Kill a Mockingbird";
  }
  print(books);

  // 5.2 Alternative way is to use "putIfAbsent" method. It is just a different
  // code style.
  // map.putIfAbsent(key, 123);
  // Add another entry to the map using "putIfAbsent" method
  print('\n***mapMethods5.2***\n');
  books.putIfAbsent("Delia Owens", () => "Where the Crawdads Sing");
  print(books);

  // 6. Copy and paste MobyDick text code from previous exercise. Count each
  // word occurrences in the text. Use "update" method.
  // map.update(word, (count) => count + 1, ifAbsent: () => 1);
  print('\n***mapMethods6***\n');
  // var mobyDickUrl =
  //     Uri.parse('https://www.gutenberg.org/files/2701/old/moby10b.txt');
  // var mobyDickFullText = (await http.get(mobyDickUrl)).body;
  // RegExp notLetterAndSpacePattern = RegExp("[^a-zA-Z ]");
  // var text = mobyDickFullText
  //     .replaceAll(notLetterAndSpacePattern, "")
  //     .toLowerCase()
  //     .split(" ");
  // var uniqueWords = Map<String, int>();
  // for (var word in text) {
  //   uniqueWords.update(word, (count) => count + 1, ifAbsent: () => 1);
  // }
  //print(uniqueWords);

  // 7. Iterate over all entries of [book => author] map and print book&author
  // for short book titles (less than 5 chars).
  // Use for loop with "map.entries" property.
  // for (var e in map.entries) {
  //   print(e);
  // }

  print('\n***mapMethods7***\n');
  for (var authors in books.entries) {
    if (authors.value.length > 30) {
      print(authors);
    }
  }

  // 7.1 Do the same as in previous exercise, but use "forEach" method in
  // functional style.
  print('\n***mapMethods7.1***\n');
  books.forEach((authors, book) {
    if (book.length > 30) {
      print('$book by $authors');
    }
  });

  // 8. Create multimap of [author => list of books]. Fill it with few entries.
  // Now create a map which contains [author => number of books] pairs. To
  // create such map use "map" method on multimap (functional style).
  // var map = multimap.map((key, value) => MapEntry(key, value.length));
  // NOTE: this method creates new map, it doesn't modify original multimap.
  print('\n***mapMethods8***\n');
  var booksAuthors = {
    "Matt Haig": ["The Midnight Library", "9 MILLION COPIES SOLD"],
    "V.E. Schwab": ["The Invisible Life of Addie LaRue", "Vicious"],
    "Taylor Jenkins Reid": [
      "The Seven Husbands of Evelyn Hugo",
      "The Atria Summer",
      "Forever"
    ],
    "F. Scott Fitzgerald": [
      "The Great Gatsby",
      "This Side of Paradise",
      "Tender Is the Night",
      "The Love of the Last Tycoon "
    ]
  };
  var numbersOfBook =
      booksAuthors.map((author, books) => MapEntry(author, books.length));
  print(numbersOfBook);
}

void mapViews() {
  // "keys" and "values" map properties do NOT COPY data, they create a view of the map.
  // These view objects are not reusable. It's safer to create new "keys" or "values" view each time you need it.

  // 1. Create "keys" view of books map (from previous exercise) and assign it to some variable. Print it.
  // Now modify original map, and print "keys" view again (refer to that local variable). Observe result.

  print('\n***mapViews1***\n');
  var books = {
    "Matt Haig": "The Midnight Library",
    "V.E. Schwab": "The Invisible Life of Addie LaRue",
    "Taylor Jenkins Reid": "The Seven Husbands of Evelyn Hugo",
    "F. Scott Fitzgerald": "The Great Gatsby",
  };
  var booksKeys = books.keys;
  print('Before modification: $booksKeys\n');

  books['F. Scott Fitzgerald'] =
      'The Complete Works'; //старий ключ + нове значення => змінюється значення для ключа
  print(
      'After modification with the addition of the existing key: $booksKeys\n');

  books['William Shakespeare'] =
      'The Complete Works'; //новий ключ + нове значення
  //print('After modification with the addition of new existing key: $booksKeys'); //Runtime exception: Concurrent modification during iteration: _Map len:5.

  //змінна booksKeys зберігає дані, присвоєні в момент ініціалізації і НЕ МОЖЕ бути змінена без ініціалізації

  // 2. Now let's correct previous exercise, and do it properly - each time you need to print "keys" view, create
  // new view object. Use "books.keys" expression to create new view.
  print('\n***mapViews2***\n');
  print('$books.keys\n');

  books['Emily Bronte'] = 'Wuthering Heights'; //новий ключ + нове значення
  print('$books.keys\n');

  // 3. Do the same for "values" view. Create "values" view, print it, modify original map, print "values" view again.
  print('\n***mapViews3***\n');
  var booksValues = books.values;
  print('Before modification: $booksValues\n');

  books['Some author'] = 'Wuthering Heights'; //новий ключ + існуюче значення
  print(
      'After modification with addition of the new key and  existing value: $booksValues\n'); //повторення не дублюються

  books['Some author'] =
      'The Complete Works'; //існуючий ключ + існуюче значення
  print(
      'After modification with addition of the existing key and   existing value: $booksValues\n'); //повторення не дублюються
  print('All pairs: $books\n');

  books['Anne Bronte'] =
      'The Tenant of Wildfell Hall'; //новий ключ + нове значення
  print(
      'After modification with addition of the new  key and new value: $booksValues\n'); //помилки не виникає, але і значення не змінюється
  print('All pairs: $books\n');
  //змінна booksValues зберігає дані, присвоєні в момент ініціалізації і більше не модифікується

  // 4. Now let's correct previous exercise, and do it properly - each time you need to print "values" view, create
  // new view object. Use "books.values" expression to create new view.
  print('\n***mapViews4***\n');
  print('All values with new ones: ${books.values}\n');
  books['Donna Tartt'] = 'The Secret History'; //новий ключ + нове значення
  print(
      'After modification with addition of the new key and  new value: ${books.values}\n');
}
