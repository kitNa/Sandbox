void main() {
  // https://dart.dev/language/collections#maps
  // https://dart.dev/guides/libraries/library-tour#maps

  // additional collections libraries:
  //  - collection - https://pub.dev/packages/collection
  //  - quiver     - https://pub.dev/packages/quiver

  // Maps are key-value collections. Maps are unordered (order is not guaranteed like in "set").
  mapOperators();
  mapMethods();
}

void mapOperators() {
  // 1. Define map with "name"=>age pairs. And print it. Use map literal " {'name': age} " syntax.

  // 2. Now define the same map using Map constructor - "Map<String, int>()". And fill map with values
  // using "[]=" operator.
  // var parts = Map<String, String>();
  // parts['engine'] = 'good';
  // parts['door'] = 'bad';

  // 3. Print age of "John" (any other name that exists in map) from the map. Use "[]" operator.
  // print(parts['engine']);

  // 4. Define constant map of "first name"=>"last name" pairs. Try to add more elements to it and observe error.
  // final constantMap = const {
  //   2: 'helium',
  //   10: 'neon',
  //   18: 'argon',
  // };
}

void mapMethods() {
  // 1. Use map from previous exercise. Print length of the map.

  // 2. Copy map from previous exercise into "namesCopy" variable. Use "Map.of()" copy constructor.

  // 3. Check if "John" exists in "namesCopy" map. Use "containsKey()" method.

  // 3. Remove "John" from "namesCopy" map. Use "remove('key')" method. Check again with "containsKey()" method.

  // TODO: add more exercises
}
