import 'package:collection/collection.dart';

void main() {
  // https://dart.dev/language/collections#lists
  // https://dart.dev/guides/libraries/library-tour#lists

  // additional collections libraries:
  //  - collection - https://pub.dev/packages/collection
  //  - quiver     - https://pub.dev/packages/quiver

  modifications();
  retrievals();
  sorting();
  zipping();
}

void modifications() {
  // 1. Create a list of your 5 favorite movies.
  print('***modifications1***');
  var movies = [
    'The Artist',
    'The Pianist',
    'The Notebook',
    'Moscati',
    'Dragonfly'
  ];
  print(movies);

  // 2. Add "The Godfather" to the end of the list.
  print('***modifications2***');
  movies.add('The Godfather');
  print(movies);

  // 3. Add "The Shawshank Redemption" to the beginning of the list.
  print('***modifications3***');
  movies.insert(0, "The Shawshank Redemption");
  print(movies);

  // 4. Add ["Pulp Fiction" and "Fight Club"] to the end of the list.
  print('***modifications4***');
  var newMovies = ["Pulp Fiction", "Fight Club"];
  movies.addAll(newMovies);
  print(movies);

  // 5. Remove "The Godfather" from the list.
  print('***modifications5***');
  movies.remove('The Godfather');
  print(movies);

  //5.1 Add 'The matrix' three times at the beginning, at the and and in the middle.
  //Remove one 'The matrix' with remove method. Observe result.
  print('***modifications5.1***');
  movies.add('The matrix');
  movies.insert(0, 'The matrix');
  movies.insert(4, 'The matrix');
  movies.remove('The matrix');
  print(movies);
  movies.removeLast();
  print(movies);

  // 6. Remove "The Shawshank Redemption" from the list.
  print('***modifications6***');
  movies.removeAt(0);
  print(movies);

  // 7. Remove "Pulp Fiction" and "Fight Club" from the list.
  print('***modifications7***');
  movies.removeRange(5, 7);
  print(movies);

  // 8. Remove second movie from the list. (use "removeAt")
  print('***modifications8***');
  movies.removeAt(1);
  print(movies);

  // 9. Remove all movies with name shorter than 10 characters. (use "removeWhere")
  print('***modifications9***');
  var moviesCopy = List.of(movies);
  moviesCopy.removeWhere((movie) => movie.length < 10);
  print(moviesCopy);

  // 10. Leave only long movies in the list (copy) longer than 10 characters. ("retainWhere")
  print('***modifications9***');
  var moviesCopy1 = List.of(movies);
  moviesCopy1.retainWhere((movie) => movie.length > 10);
  print(moviesCopy1);
}

void retrievals() {
  // 1. Create a list of your 5 friends.
  print('***retrievals1***');
  var friends = ['Luba', 'Katya', 'Tanya', 'Kristina', 'Lena'];
  print(friends);

  // 2. Print the first and the last friend. ("first", "last")
  print('***retrievals2***');
  print(friends.first);
  print(friends.last);

  // 3. Print the first three friends. ("take")
  print('***retrievals3***');
  print(friends.take(3));

  // 4. Print the rest of friends skipping first three.  ("skip")
  print('***retrievals4***');
  print(friends.skip(3));

  // 5. Print friends with names shorter than 5 characters. ("where")
  print('***retrievals5***');
  print(friends.where((friend) => friend.length < 5));

  // 6. Find position of "Sasha" in the list. ("indexOf")
  print('***retrievals6***');
  print(friends.indexOf('Tanya'));

  // 7. Check if "Masha" is in the list. ("contains")
  print('***retrievals7***');
  print(friends.contains('Masha'));

  // 8. Check if very long name (> 7 chars) is in the list. ("any")
  print('***retrievals8***');
  print(friends.any((friend) => friend.length > 7));

  // 9. Check if all names start with consonant. ("every") NOTE: function that returns boolean is called "predicate"
  // (https://en.wikipedia.org/wiki/Predicate_(mathematical_logic)) - function that tells if "element matches condition"
  print('***retrievals9***');
  var vowels = ['a', 'e', 'y', 'i', 'u', 'o'];
  print(friends.every((friend) => !vowels.contains(friend[0])));

  // 10. Who is on the second position? ("elementAt")
  print('***retrievals10***');
  print(friends.elementAt(2));

  // 11. Find first and last friend with name starting with "L". ("firstWhere" and "lastWhere")
  print('***retrievals11***');
  print(friends.firstWhere((friend) => friend[0] == 'L'));
  print(friends.lastWhere((friend) => friend[0] == 'L'));

  // 12. Now find positions of those ^^^ first and last friends starting with "L". ("firstIndexWhere" and "lastIndexWhere")
  print('***retrievals11***');
  print(friends.indexWhere((friend) => friend[0] == 'L'));
  var firstStartingWithL =
      friends.indexed.firstWhere((friend) => friend.$2[0] == 'L').$1;
  print(firstStartingWithL);
  print(friends.lastIndexWhere((friend) => friend[0] == 'L'));

  // 13. Create alphabetically sorted list of your friends. Trim list with "skipWhile" and "takeWhile" to leave only
  //   names from "B" to "K".
  print('***retrievals13***');
  var sortedFriends = List.of(friends);
  sortedFriends.sort();
  print(sortedFriends);
  var friendsBeforeB =
      sortedFriends.skipWhile((friend) => friend[0].compareTo('L') < 0);
  print(friendsBeforeB);
  var friendsBetweenBandM =
      friendsBeforeB.takeWhile((friend) => friend[0].compareTo('L') <= 0);
  print(friendsBetweenBandM);

  // 14. Create a sublist of friends from 2 to 4 position. ("sublist")
  print('***retrievals14***');
  print(friends.sublist(2, 5));
}

void sorting() {
  var friends = ['Dania', 'Artem', 'Kiril', 'Mila', 'Orest'];

  // 1. Create a list of friends of your kid. Sort them by name alphabetically. Print them. (use String.compareTo)
  print('\n***sorting1***\n');
  friends.sort((a, b) => a.compareTo(b));
  print(friends);

  // 2. Now sort them by name length. Print them.
  print('\n***sorting2***\n');
  friends.sort((a, b) => a.length.compareTo(b.length));
  print(friends);

  // 3. Sort them in reverse alphabetical order by name. (don't use "reversed", define your comparator). Hint: use
  //   "compareTo" and negate result.
  print('\n***sorting3***\n');
  friends.sort((a, b) => -a.compareTo(b));
  print(friends);
}

void zipping() {
  // import https://pub.dev/packages/collection
  // https://stackoverflow.com/a/70727527/3606820

  // 1. Create a list of your 5 favorite books. And create another list with
  //   corresponding authors. Zip them together with IterableZip. Print them.
  print('\n***zipping1***\n');
  var books = [
    'The Alchemist',
    'Atlas Shrugged',
    'The Black Swan',
    'The Thorn Birds',
    'Men Are from Mars, Women Are from Venus'
  ];
  var authors = [
    'Paulo Coelho',
    'Ayn Rand',
    'Nassim Taleb',
    'Colin McCullough',
    'John Gray'
  ];
  List<(String, String)> booksList = [];
  for (final pairs in IterableZip([books, authors])) {
    booksList.add((pairs[0], pairs[1]));
  }
  print(booksList);
}
