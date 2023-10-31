import 'dart:collection';

void main() {
  // SET - множина, набір, діаграми Венна
  // https://dart.dev/language/collections#sets
  // https://dart.dev/guides/libraries/library-tour#sets

  // - set is an unordered collection
  // - set doesn't allow duplicates

  // To create a set, use a set literal or the Set constructor:
  // var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};

  addDups();
  noOrdering();
  emptySet();
  setOperators();
}

void addDups() {
  // 1. Create a set of mobile phone brands. Try to add duplicates and observe
  // the result.

  var phoneBrands = {'Samsung', 'Apple', 'Xiaomi', 'Huawei', 'Realme'};
  print('\n***addDups1***\n');
  var newBrand1 = 'Meizu';
  var newBrand2 = 'Meizu';
  phoneBrands.add(newBrand1);
  phoneBrands.add(newBrand2); //item was added only once
  phoneBrands.add('Meizu'); //item was added only once
  phoneBrands.add('Меіzu'); //an element with letters of a different alphabet was added successfully
  print(phoneBrands);

  //1.1 Додати в сет усі унікальні слова деякого тексту.
  var text = '''
  Стара жінка зсунула вниз окуляри й, дивлячись поверх них, роззирнулася по 
  кімнаті; потім підняла окуляри на чоло й поглянула з-під них. Вона пішла до
   відчинених дверей, стала на порозі й повела оком по грядках помідорів,
    зарослих дурманом, — то був її "город". Тома не видно ніде. Раптом позад 
    неї щось шурхнуло, і вона обернулася — саме вчасно, щоб схопити за полу 
    куртки невеликого хлопчиська й не дати йому втекти.
  ''';

  print('\n***addDups1.1***\n');
  var words = text.toLowerCase().split(' ');
  print(words.length);
  var uniqueWords = words.toSet();
  print(uniqueWords.length);

  // 2. Create a set of animals from literal where duplicates are defined.
  // Observe result.
  print('\n***addDups2***\n');
  var animals = {
    'cat',
    'dog',
    'goldfish',
    'guinea pig',
    'hamster',
    'mouse',
    'tortoise',
    'tortоіse', //with Ukrainian letters
    'tortoise'
  }; //Two elements in a set literal shouldn't be equal.

  //The turtle will be written only twice
  print(animals);
}

void noOrdering() {
  // Sets created with a literal or the Set() constructor are actually ordered.
  // But this should never be considered as a guarantee.

  // 1. Given a set of letters from literal:
  print('\n***noOrdering1***\n');
  var letters = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'};
  // Print first, 2th, and last elements. Observe result.
  print(letters);
  print("First element is: ${letters.first}"); //a
  print("Second element is: ${letters.elementAt(1)}"); //b
  print("Last element is: ${letters.last}"); //j

  // 2. Now someone changed set implementation under the hood. It's still a set,
  // but now ordering is broken. Print first, 5th, and last elements. Observe
  // result.
  print('\n***noOrdering2***\n');
  letters = HashSet.of(letters); // someone changed implementation
  print(letters); //e, a, d, j, c, h, b, g, f, i
  print("First element is: ${letters.first}"); //e
  print("Fifth element is: ${letters.elementAt(4)}"); //c
  print("Last element is: ${letters.last}"); //i

  //2.2 Додати нові елементи і перевірити порядок
  letters.addAll(['k', 'l', 'm', 'n']);
  print(letters);
  print("First element is: ${letters.first}");
  print("Fifth element is: ${letters.elementAt(4)}");
  print("Last element is: ${letters.last}");

  // 3. Try using "elementAt" on "letters" set from previous exercise. It works
  // the same as "[index]" operator on lists. Note that usually "elementAt"
  // should not be used on sets, as it doesn't make sense, and no guarantees.
  print('\n***noOrdering3***\n');
  print(letters);
  print("Fifth element is: ${letters.elementAt(4)}"); //c
  //HashSet.of rearranged the list into a new order, but it is fixed for all operations

  // 4. Similarly, all the other order dependent operators don't work well with
  // sets. Try "take" and "skip" operators. Observe result.
  print('\n***noOrdering4***\n');
  print(letters);
  print(letters.take(5));
  print(letters.skip(5));

  // NOTE: never depend on order in sets. If you have to preserve ordering, then
  // use LinkedHashSet type explicitly. LinkedHashSet - no duplicates, but order
  // is defined. It's a set, but it's also a linked list.
}

void emptySet() {
  // NOTE: you can't define empty set with " {} ". It will be a map.
  // To create set you need to use either:
  // - <String>{}
  // - Set<String> mySet = {};

  // 1. Create empty set. Fill it with toys. Observe result.
  print('\n***emptySet1***\n');
  var toysList = ['boll', 'car', 'doll', 'cat', 'pyramid'];

  //var toysSet = {};
  //toysSet.addAll(toysList); //The argument type 'List<String>' can't be assigned to the parameter type 'Map<dynamic, dynamic>'.

  var toysSet = <String>{};
  toysSet.addAll(toysList);
  print(toysSet);

  Set<String> toysSet1 = {};
  toysSet1.addAll(toysList);
  print(toysSet1);
}

void setOperators() {
  // 1. Create a set of clothes for your kid. (набір одягу для дитини). Check if "socks" are in the set.
  // Use operator "contains".
  print('\n***setOperators1***\n');
  var clothes = {'T-shirt', 'socks', 'pantyhose', 'pants', 'blouse', 'dress', 'jacket'};
  print('Are the socks in the list? ${clothes.contains('socks')}');

  // 2. Create a set of your 5 favorite colors, and a set of favorite colours of your kid. Check if there are any
  // common colors. Use operator "intersection".
  print('\n***setOperators2***\n');
  var myFavoriteColors = {'green', 'cyanogen', 'turquoise', 'aquamarine', 'blue'};
  var kidFavoriteColors = {'black', 'blue', 'violet', 'peachy'};
  print('Colors that both like: ${myFavoriteColors.intersection(kidFavoriteColors)}');

  // 3. Create a set of your 5 favorite colors, and a set of favorite colours of your kid. Join them together to create
  // a set of all colors you both like. Use operator "union".
  print('\n***setOperators1***\n');
  print('All colors that we like: ${myFavoriteColors.union(kidFavoriteColors)}');

  // 4. Create a set of your 5 favorite colors, and a set of favorite colours of your kid. Create a set of colors that
  // you like, but your kid doesn't. Use operator "difference" (semantically similar to "removeAll").
  print('\n***setOperators1***\n');
  print('Colors that just I like: ${myFavoriteColors.difference(kidFavoriteColors)}');

  // 5. Find "blue" in the set of your favorite colors. Use method "lookup". Note that it returns element, not boolean.
  print('\n***setOperators1***\n');
  print('MyFavoriteColors set has ${myFavoriteColors.lookup('blue')} ');
}
