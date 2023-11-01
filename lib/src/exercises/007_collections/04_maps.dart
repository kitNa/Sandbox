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
  print('Is William in writersCopy keys? ${writersCopy.containsKey('William')}');
  print('Is Dacre in writersCopy values? ${writersCopy.containsValue('Dacre')}');

  // 4. Remove "John" from "namesCopy" map. Use "remove('key')" method. Check again with "containsKey()" method.
  print('\n***mapMethods4***\n');
  writersCopy.remove('William');
  print('Is William in writersCopy keys? ${writersCopy.containsKey('William')}');
  print('Is Dacre in writersCopy values? ${writersCopy.containsValue('Dakins')}');

  // 5.1 Crate map of [Book => Author] pairs with few entries. Add new entry to
  // the map if map doesn't contain it. Use following approach:
  // if (!map.containsKey(key)) {
  //   map[key] = 123;
  // }


  // 5.2 Alternative way is to use "putIfAbsent" method. It is just a different
  // code style.
  // map.putIfAbsent(key, 123);
  // Add another entry to the map using "putIfAbsent" method.

  // 6. Copy and paste MobyDick text code from previous exercise. Count each
  // word occurrences in the text. Use "update" method.
  // map.update(word, (count) => count + 1, ifAbsent: () => 1);
  var mobyDickUrl = Uri.parse('https://www.gutenberg.org/files/2701/old/moby10b.txt');
  var mobyDickFullText = (await http.get(mobyDickUrl)).body;

  // 7. Iterate over all entries of [book => author] map and print book&author
  // for short book titles (less than 5 chars).
  // Use for loop with "map.entries" property.
  // for (var e in map.entries) {
  //   print(e);
  // }

  // 7.1 Do the same as in previous exercise, but use "forEach" method in
  // functional style.


  // 8. Create multimap of [author => list of books]. Fill it with few entries.
  // Now create a map which contains [author => number of books] pairs. To
  // create such map use "map" method on multimap (functional style).
  // var map = multimap.map((key, value) => MapEntry(key, value.length));
  // NOTE: this method creates new map, it doesn't modify original multimap.
}




































// ----------------------
