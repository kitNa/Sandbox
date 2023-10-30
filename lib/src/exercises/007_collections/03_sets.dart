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

  // 2. Create a set of animals from literal where duplicates are defined.
  // Observe result.
  // var set = {'a', 'b', 'c', 'a', 'b', 'c', 'c', 'c', 'c', 'c', 'c'};
}

void noOrdering() {
  // Sets created with a literal or the Set() constructor are actually ordered.
  // But this should never be considered as a guarantee.

  // 1. Given a set of letters from literal:
  var letters = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'};
  // Print first, 2th, and last elements. Observe result.

  // 2. Now someone changed set implementation under the hood. It's still a set,
  // but now ordering is broken. Print first, 5th, and last elements. Observe
  // result.
  letters = HashSet.of(letters); // someone changed implementation

  // 3. Try using "elementAt" on "letters" set from previous exercise. It works
  // the same as "[index]" operator on lists. Note that usually "elementAt"
  // should not be used on sets, as it doesn't make sense, and no guarantees.

  // 4. Similarly, all the other order dependent operators don't work well with
  // sets. Try "take" and "skip" operators. Observe result.

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
  var set = HashSet.from({'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'});
  print("element at: ${set.elementAt(0)}");
}

void setOperators() {
  // 1. Create a set of clothes for your kid. (набір одягу для дитини). Check if "socks" are in the set.
  // Use operator "contains".

  // 2. Create a set of your 5 favorite colors, and a set of favorite colours of your kid. Check if there are any
  // common colors. Use operator "intersection".

  // 3. Create a set of your 5 favorite colors, and a set of favorite colours of your kid. Join them together to create
  // a set of all colors you both like. Use operator "union".

  // 4. Create a set of your 5 favorite colors, and a set of favorite colours of your kid. Create a set of colors that
  // you like, but your kid doesn't. Use operator "difference" (semantically similar to "removeAll").

  // 5. Find "blue" in the set of your favorite colors. Use method "lookup". Note that it returns element, not boolean.
}









































// ---------------------------
