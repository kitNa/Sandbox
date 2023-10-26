void main() {
  // https://dart.dev/language/collections#lists
  // https://dart.dev/guides/libraries/library-tour#lists

  // additional collections libraries:
  //  - collection - https://pub.dev/packages/collection
  //  - quiver     - https://pub.dev/packages/quiver

  modifications();
  retrievals();
  zipping();
  sorting();
}

void modifications() {
  // 1. Create a list of your 5 favorite movies.
  // 2. Add "The Godfather" to the end of the list.
  // 3. Add "The Shawshank Redemption" to the beginning of the list.
  // 4. Add ["Pulp Fiction" and "Fight Club"] to the end of the list.
  // 5. Remove "The Godfather" from the list.
  // 6. Remove "The Shawshank Redemption" from the list.
  // 7. Remove "Pulp Fiction" and "Fight Club" from the list.
  // 8. Remove second movie from the list. (use "removeAt")
  // 9. Remove all movies with name shorter than 10 characters. (use "removeWhere")
  // 10. Leave only long movies in the list (copy) longer than 10 characters. ("retainWhere")
}

void retrievals() {
  // 1. Create a list of your 5 friends.
  // 2. Print the first and the last friend. ("first", "last")
  // 3. Print the first three friends. ("take")
  // 4. Print the rest of friends skipping first three.  ("skip")
  // 5. Print friends with names shorter than 5 characters. ("where")
  // 6. Find position of "Sasha" in the list. ("indexOf")
  // 7. Check if "Masha" is in the list. ("contains")
  // 8. Check if very long name (> 7 chars) is in the list. ("any")
  // 9. Check if all names start with consonant. ("every") NOTE: function that returns boolean is called "predicate"
  // (https://en.wikipedia.org/wiki/Predicate_(mathematical_logic)) - function that tells if "element matches condition"
  // 10. Who is on the second position? ("elementAt")
  // 11. Find first and last friend with name starting with "L". ("firstWhere" and "lastWhere")
  // 12. Now find positions of those ^^^ first and last friends starting with "L". ("firstIndexWhere" and "lastIndexWhere")



  // 13. Create alphabetically sorted list of your friends. Trim list with "skipWhile" and "takeWhile" to leave only
  //   names from "B" to "K".

  // 14. Create a sublist of friends from 2 to 4 position. ("sublist")
}

void sorting() {
  // 1. Create a list of friends of your kid. Sort them by name alphabetically. Print them. (use String.compareTo)
  // 2. Now sort them by name length. Print them.
  // 3. Sort them in reverse alphabetical order by name. (don't use "reversed", define your comparator). Hint: use
  //   "compareTo" and negate result.
}

void zipping() {
  // import https://pub.dev/packages/collection
  // https://stackoverflow.com/a/70727527/3606820

  // 1. Create a list of your 5 favorite books. And create another list with
  //   corresponding authors. Zip them together with IterableZip. Print them.
}
