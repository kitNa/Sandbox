// import 'package:http/http.dart' as http;
import 'dart:convert' show utf8;

Future<void> main() async {
  // https://dart.dev/language/built-in-types

  // Those types are built-in in Dart, they are available everywhere without any imports.
  // Everything in Dart is an object, even numbers, functions, null, etc. Hence, everything can be null and every type
  // has a constructor.

  // HEX  - hexadecimal  (16)
  // DEC - decimal  (10)
  // OCT - octal  (8)
  // BIN - binary (2)

  numbers();
  strings();
  mobyDick();
}

void numbers() {
  // https://dart.dev/language/built-in-types#numbers
  // https://dart.dev/guides/language/numbers

  // 1. Define a HEX (hexadecimal, or 16 radix) int variable with "deadbeef" value. Print it in 10, 8 (octal) and 2
  // radixes.
  print('***numbers1***');

  print((0Xdeadbeef).toRadixString(16));
  int hex = 0Xdeadbeef;

  print(hex.toRadixString(10));
  print(hex.toRadixString(8));
  print(hex.toRadixString(2));

  // 2. Define "min" variable as simple int, and "max" variable as HEX int. Pick any values you like, but max should be
  // greater than min. Calculate sum of all numbers between them. And then print min, max, sum in 10 and 16 radixes.
  print('***numbers2***');

  int intMin = 10;
  int intMax = 0Xf;
  var sum = 0;

  for(var i = intMin; i<intMax; i++){
    sum += i;
  }

  print('Min in the decimal number system ${intMin.toRadixString(10)}\n'
      'Min In hexadecimal number system ${intMin.toRadixString(16)}');
  print('Max in the decimal number system ${intMax.toRadixString(10)}\n'
      'Max In hexadecimal number system ${intMax.toRadixString(16)}');
  print('Sum in the decimal number system ${sum.toRadixString(10)}\n'
      'Sum In hexadecimal number system ${sum.toRadixString(16)}');

  // 3. Define double "min" and "max" variables. Calculate sum of all numbers between them with increment step 0.1.
  // Use this snippet as an iteration example:
  // for (var i = 0.0; i < 1.0; i += 0.1) {
  // Use "+=" operator to add to the sum variable.
  print('***numbers3***');
  double doubleMin = 0.567;
  double doubleMax = 1.432;
  var doubleSum = 0.0;

  for(var i = doubleMin; i < doubleMax; i += 0.1){
    doubleSum += i;
  }

  print(doubleSum);

  // Then print following methods results for the calculated sum:
  // - toStringAsFixed(2) - prints number with 2 digits after decimal point
  print(doubleSum.toStringAsFixed(2));
  // - toStringAsExponential(4) - prints number in exponential format with 4 digits after decimal point
  print(doubleSum.toStringAsExponential(4));
  // - toStringAsPrecision(2) - prints number with 2 significant digits
  print(doubleSum.toStringAsPrecision(2));
  // - floor() - returns largest integer value that is less than or equal to the number
  print(doubleSum.floor());
  // - ceil() - returns smallest integer value that is greater than or equal to the number
  print(doubleSum.ceil());
  // - round() - returns integer value that is closest to the number
  print(doubleSum.round());
  // - toInt() - returns value truncated to integer
  print(doubleSum.toInt());

  // 4. Parse "1234" string to int and print it. Then parse "1234.5" string to int and print it. What happens?
  print('***numbers3***');
  String intString = "1234";
  String doubleString = "1234.5";
  print(int.parse(intString));

  //FormatException: Invalid radix-10 number (at character 1)
  // 1234.5
  // print(int.parse(doubleString));

  // 5. Parse "1234" string to double and print it. Then parse "1234.5" string to double and print it.
  print('***numbers3***');
  print(double.parse(intString));
  print(double.parse(doubleString));
}

void strings() {
  // https://dart.dev/language/built-in-types#strings
  // https://dart.dev/guides/libraries/library-tour#strings-and-regular-expressions

  // 1. Define few strings with your favorite names. Concatenate (join) them in three different ways:
  // - writing names as string literals one after another
  // - using + operator
  // - using interpolation - e.g. "$str1$str2$str3"

  // 2. Define a *multiline* string with a short letter to your friend. Make sure it has header and footer.
  // Print it in uppercase and lowercase.
  // Use toUpperCase() and toLowerCase() string methods.

  // 3. Define three strings with "KATE", "kate" and "Kate" values. Compare them with == operator. Are they equal?

  // 4. Now apply toUpperCase() and toLowerCase() methods to variables from previous exercise and compare them again.
  //    This is the way to compare strings ignoring their case.

  // 5. Every object in Dart has a toString() method. Print toString() result for strings from previous exercise.
  //    And print toString() result for int and double numbers. You can call toString() on any object.

  // 6. Define a list of your favorite brand names. Find the longest one and print it. Use "length" property of
  //    string to get its length.
  //    print("some string".length);

  // 7. Define the list of vowels ("a", "e" ...). Use list of brands from previous exercise. For each vowel, print
  //    which brands names contain it. Use "contains" method of string to check if it contains a substring.

  // 8. Use list of brands and vowels from previous exercises. Print all brands that start with vowel. Use "startsWith"
  //    method of string to check if it starts with a substring.

  // 9. Use list of brands and vowels from previous exercises. Print all brands that end with vowel. Use "endsWith"
  //    method of string to check if it ends with a substring.

  // 10. Given the string "kate owns her fate". Replace all "ate" with "8". Use "replaceAll" method of string.

  // 11. Given the list of strings:
  //     var congratulations = [
  //       '  Congratulations!   ',
  //       'Bonjour     ',
  //       '       Hola',
  //     ];
  //     Print each without extra spaces. Try "trim", "trimLeft", "trimRight" methods of string.

  // 12. Given the string "kate owns her fate". Split it by space and print each word on a new line. Use "split".
  //     Then join it back with "-" separator and print it. Use "join".

  // 13. Given the string "kate owns her fate". Split it into words and print them in reverse order.
  // Use "split" method and "reversed" property.

  // 14. Given the list of strings:
  //     var supers = ["Superman", "Supercar", "Superwoman", "Superhero"];
  // Extract parts that follow the "Super" prefix and print them. Use "substring" method.

  // 15. Use list of brands and list of vowels from previous exercises. For each brand, check where it has more
  // vowels - in the beginning or in the end. Use "length" property of string to get its length and find where is the
  // middle of the word. Use "indexOf" method to find positions of the vowels.
}

Future<void> mobyDick() async {
  // This is a complex exercise to apply all the knowledge you learned so far to perform some realistic text processing.

  // Given "Moby Dick" text:
  /*
  var mobyDickUrl = Uri.parse('https://www.gutenberg.org/files/2701/old/moby10b.txt');
  var mobyDickFull = (await http.get(mobyDickUrl)).body;
   */

  // 1. Cut the blah-blah-blah parts. The actual novel starts with
  // "CHAPTER 1"
  // and ends with
  // And footer blah-blah-blah starts with
  // "End of this Project Gutenberg etext"
  // Use "indexOf" and "substring" methods to cut off those unnecessary header and footer parts and leave only the
  // novel text itself as a separate variable "mobyDick".

  // 2. Count frequency of each letter.
  // To find the total number of letters, and skip spaces, numbers and other non-letter symbols, use following snippet.
  // (don't bother about regular expressions yet, we'll learn them later; in a nutshell, it's a special language to
  // define textual patterns; in this case patterns is "any uppercase or lowercase letter of English alphabet")
  /*
  var letterPattern = RegExp("[A-Za-z]");
  var numLetters = 0;
  var letterPos = -1;
  while ((letterPos = mobyDick.indexOf(letterPattern, letterPos + 1)) >= 0) {
    numLetters++;
  }
   */
  // Don't forget to use "toLowerCase" method to count upper case and lower case letters as the same.

  // 4. What is the balance between vowels and consonants?

  // 4. Count how many words are there in the novel. Use "split" method.

  // 5. Count how many times each word is used in the novel. Use "split" method and "Map" collection. Word should be
  //    the key, and number of times it is used should be the value in the map.
  // Use following snippet to manipulate the map:
  /*
  var wordCounts = Map<String, int>();
  var word = 'some_word';
  wordCounts[word] = (wordCounts[word] ?? 0) + 1;
   */
}
