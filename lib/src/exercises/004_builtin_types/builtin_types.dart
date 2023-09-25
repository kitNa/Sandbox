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
  print('\n***numbers1***\n');
  print((0xDEADBEEF).toRadixString(16));
  int hex = 0xDEADBEEF;
  print(hex.toRadixString(10));
  print(hex.toRadixString(8));
  print(hex.toRadixString(2));

  // 2. Define "min" variable as simple int, and "max" variable as HEX int. Pick any values you like, but max should be
  // greater than min. Calculate sum of all numbers between them. And then print min, max, sum in 10 and 16 radixes.
  print('***numbers2***');
  int intMin = 10;
  int intMax = 0Xf;
  var sum = 0;
  for (var i = intMin; i<intMax; i++) {
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
  print('\n***numbers3***\n');
  double doubleMin = 0.567;
  double doubleMax = 1.432;
  var doubleSum = 0.0;
  for (var i = doubleMin; i < doubleMax; i += 0.1) {
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
  print('\n***numbers4***\n');
  String intString = "1234";
  String doubleString = "1234.5";
  print(int.parse(intString));

  //FormatException: Invalid radix-10 number (at character 1)
  // 1234.5
  // print(int.parse(doubleString));

  // 5. Parse "1234" string to double and print it. Then parse "1234.5" string to double and print it.
  print('\n***numbers5***\n');
  print(double.parse(intString));
  print(double.parse(doubleString));
}

void strings() {
  // https://dart.dev/language/built-in-types#strings
  // https://dart.dev/guides/libraries/library-tour#strings-and-regular-expressions
  print('\n***strings1***\n');
  String name1 = 'Katya';
  String name2 = 'Sasha';
  String name3 = 'Margo';
  // 1. Define few strings with your favorite names. Concatenate (join) them in three different ways:
  // - writing names as string literals one after another
  print ('Katya, Sasha, Margo');
  // - using + operator
  print(name1 +', '+ name2 + ', '+ name3);
  // - using interpolation - e.g. "$str1$str2$str3"
  print('$name1, $name2, $name3');

  // 2. Define a *multiline* string with a short letter to your friend. Make sure it has header and footer.
  // Print it in uppercase and lowercase.
  // Use toUpperCase() and toLowerCase() string methods.
  print('\n***strings2*** \n');
  // String letter = 'Hello my dear friend!\n'
  //     'I\'m fine, but I missed you a lot.\n'
  //     'I look forward to your visit. \n'
  //     'With love, from your best friend Katya.\n';
  String letter = ''' Hello my dear friend!
      'I\'m fine, but I missed you a lot.
      'I look forward to your visit. 
      'With love, from your best friend Katya.''';
  print(letter);
  print(letter.toLowerCase());
  print(letter.toUpperCase());

  // 3. Define three strings with "KATE", "kate" and "Kate" values. Compare them with == operator. Are they equal?
  print('\n***strings3*** \n');
  String KATE = 'KATE';
  String Kate = 'Kate';
  String kate = 'kate';
  print(KATE == Kate);
  print(kate == Kate);
  print(kate == KATE);

  // 4. Now apply toUpperCase() and toLowerCase() methods to variables from previous exercise and compare them again.
  //    This is the way to compare strings ignoring their case.
  print('\n***strings4*** \n');
  print(KATE.toUpperCase() == Kate.toUpperCase());
  print(kate.toLowerCase() == Kate.toLowerCase());
  print(kate.toLowerCase() == KATE.toLowerCase());

  // 5. Every object in Dart has a toString() method. Print toString() result for strings from previous exercise.
  //    And print toString() result for int and double numbers. You can call toString() on any object.
  print('\n***strings5*** \n');
  int a = 12;
  double b = 12.567;
  print(Kate.toString());
  print(KATE.toString());
  print(kate.toString());
  print(a.toString());
  print(b.toString());

  // 6. Define a list of your favorite brand names. Find the longest one and print it. Use "length" property of
  //    string to get its length.
  //    print("some string".length);
  print('\n***strings6*** \n');
  var brands = ['H&M', 'ZARA', 'RESERVED', 'Adidas', 'DeeZee', 'SINSAY', 'ISSA'];
  //The variable longestName must be initialized with a value, since the length property cannot be called on a null value (line 163)
  String longestName = brands[0];
  for (var i = 1; i < brands.length; i++) {
    if (longestName.length < brands[i].length) {
      longestName = brands[i];
    }
  }
  print('The longest brand name is $longestName with length ${longestName.length}');

  // 7. Define the list of vowels ("a", "e" ...). Use list of brands from previous exercise. For each vowel, print
  //    which brands names contain it. Use "contains" method of string to check if it contains a substring.
  print('\n***strings7*** \n');
  var vowels = ['a', 'e', 'y', 'i', 'u', 'o'];
  bool brandFound = false;
  for (var letter in vowels) {
    print('Letter $letter includes the names of such brands:');
    for (var brand in brands) {
      if (brand.toLowerCase().contains(letter)){
        brandFound = true;
        print(brand);
      }
    }
    if (!brandFound) {
      print('There are no such brands');
    }
    brandFound = false;
  }


  // 8. Use list of brands and vowels from previous exercises. Print all brands that start with vowel. Use "startsWith"
  //    method of string to check if it starts with a substring.
  print('\n***strings8*** \n');
  print('Brands that start with vowel:');
  for (var brand in brands) {
    for (var vowel in vowels) {
      if (brand.toLowerCase().startsWith(vowel)) {
        print(brand);
      }
    }
  }

  // 9. Use list of brands and vowels from previous exercises. Print all brands that end with vowel. Use "endsWith"
  //    method of string to check if it ends with a substring.
  print('\n***strings9*** \n');
  print('Brands that end with vowel:');
  for (var brand in brands) {
    for (var vowel in vowels) {
      if (brand.toLowerCase().endsWith(vowel)) {
        print(brand);
      }
    }
  }

  // 10. Given the string "kate owns her fate". Replace all "ate" with "8". Use "replaceAll" method of string.
  print('\n***strings10*** \n');
  String sentence = "kate owns her fate";
  print(  sentence.replaceAll('ate', '8'));

  // 11. Given the list of strings:
  //     var congratulations = [
  //       '  Congratulations!   ',
  //       'Bonjour     ',
  //       '       Hola',
  //     ];
  //     Print each without extra spaces. Try "trim", "trimLeft", "trimRight" methods of string.
  print('\n***strings11*** \n');
  var congratulations = [
        '  Congratulations!   ',
        'Bonjour     ',
        '       Hola',
      ];
  print('***With trim method: ');
  for (var word in congratulations) {
        print(word.trim());
  }
  print('***With trimLeft method: ');
  for (var word in congratulations) {
    print(word.trimLeft());
  }
  print('***With trimRight method: ');
  for (var word in congratulations) {
    print(word.trimRight());
  }

  // 12. Given the string "kate owns her fate". Split it by space and print each word on a new line. Use "split".
  //     Then join it back with "-" separator and print it. Use "join".
  print('\n***strings12*** \n');
  var words = sentence.split(' ');
  for (var word in words) {
    print(word);
  }
  print(words.join(' '));

  // 13. Given the string "kate owns her fate". Split it into words and print them in reverse order.
  // Use "split" method and "reversed" property.
  print('\n***strings13*** \n');
  for (var word in reversedSentence('kate owns her fate')) {
    print(word);
  }

  // 14. Given the list of strings:
  //     var supers = ["Superman", "Supercar", "Superwoman", "Superhero"];
  // Extract parts that follow the "Super" prefix and print them. Use "substring" method.
  print('\n***strings14*** \n');
  var supers = ["Superman", "Supercar", "Superwoman", "Superhero"];
  var prefix = 'Super';
  for (var word in supers) {
    print(word.substring(prefix.length));
  }

  // 15. Use list of brands and list of vowels from previous exercises. For each brand, check where it has more
  // vowels - in the beginning or in the end. Use "length" property of string to get its length and find where is the
  // middle of the word. Use "indexOf" method to find positions of the vowels.
  print('\n***strings15*** \n');
  var middleOfTheWord = 0;
  var vowelsAtTheEnd = 0;
  var vowelsAtTheBeginning = 0;
  for (var brand in brands) {
    brand = brand.toLowerCase();
    vowelsAtTheEnd = 0;
    vowelsAtTheBeginning = 0;
    middleOfTheWord = (brand.length/2).ceil();
    for (var vowel in vowels) {
      if (brand.contains(vowel)) {
        for  (var i = 0; i < brand.length; i++ ) {
          var vowelIndex = brand.indexOf(vowel, i);
          if (i == vowelIndex) {
            if (vowelIndex < middleOfTheWord) {
              vowelsAtTheBeginning += 1;
            } else if (vowelIndex > middleOfTheWord) {
              vowelsAtTheEnd += 1;
            }
          }
        }
      }
    }
    brand = brand.toUpperCase();
    if (vowelsAtTheBeginning > vowelsAtTheEnd) {
      print("The $brand has more vowels at the beginning");
    } else if (vowelsAtTheBeginning < vowelsAtTheEnd) {
      print("The $brand has more vowels at the end");
    } else if (vowelsAtTheBeginning == vowelsAtTheEnd && vowelsAtTheBeginning != 0) {
      print('The name of the brane $brand has the same number of vowels'
          ' at the beginning and at the end');
    } else {
      print('There are no vowels in the $brand brand name');
    }
  }
}

Iterable<String> reversedSentence (String sentence) {
  print('listOfVowels method!');
  var words = sentence.split(' ');
  return words.reversed;
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
