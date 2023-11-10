import 'dart:math';

import 'package:mongo_dart/mongo_dart.dart';

void main() {
  // https://dart.dev/language/functions#generators

  syncGenerators();
  // asyncGenerators(); --->>>> separate topic, will learn it later
}

void syncGenerators() {
  // 1. Create a sync generator function which will generate a sequence of
  // numbers from 1 to 5 and also on each iteration prints something
  // ("generating number $num" for example). Call it and iterate over the
  // result, print each number in the loop.
  // NOTE that generator function is lazy. It will not generate value until
  // you request it.
  print('\n***syncGenerators1***\n');
  Iterable<int> generator(int num) sync* {
    int i = 1;
    int step = 1;
    while (i <= num) {
      print("generating number $i:");
      yield i++;
      print('after yield ${step++}');
    }
  }
  generator(5).take(3).forEach((num) {
    print('$num');
  });

  // 2. Create a sync generator function which will *INFINITELY* generate random
  // funny names from combining random elements of two lists "funnyPrefix"
  // and "funnySuffix". Also on each iteration print the name in generator.
  // Call it 10 times and note that it is lazy and won't generate anything
  // until you request it.
  print('\n***syncGenerators2***\n');
  var funnyPrefix = [
    'green',
    'lame',
    'aromatic',
    'biting',
    'thick',
    'high',
    'wicked',
    'barbed',
    'brilliant',
    'hot',
  ];
  var funnySuffix = [
    'cat',
    'potato',
    'sponge',
    'sausage',
    'egg',
    'cracker',
    'sandwich',
    'pillar',
    'suitcase',
    'pig'
  ];
  Iterable<String> funnyNamesGenerator() sync* {
    var random = Random();
    while (true) {
      var prefixIndex = random.nextInt(10);
      var suffixIndex = random.nextInt(10);
      print('Before generating: ${funnyPrefix[prefixIndex]} ${funnySuffix[suffixIndex]}');
      yield '${funnyPrefix[prefixIndex]} ${funnySuffix[suffixIndex]}';
      print('After generating: ${funnyPrefix[prefixIndex]} ${funnySuffix[suffixIndex]}');
    }
  }
  var fiveFunnyNames = funnyNamesGenerator().take(5);
  fiveFunnyNames.forEach((name) {
    print('$name');
  });

  // 3. Create a sync generator function which will return lines from list
  // (in real world, this could be a file). And on each iteration print
  // "reading line $line".
  // Call it and limit the iterator by using any combination of
  // skip/take/skipWhile/takeWhile methods. For example,
  // take while !line.startsWith("desired prefix")
  // EXAMPLE:
  // var veryLongListSize = 100000; // imagine this is a huge file, like 100Gb
  // var veryLongList = List.generate(veryLongListSize, (index) => index);
  // Iterable<int> syncGenerator() sync* {
  //   for (var i in veryLongList) {
  //     // in real life, here we will be reading line from file
  //     print("generating number $i");
  //     yield i;
  //   }
  // }
  // var generatedIterable = syncGenerator();
  // generatedIterable.take(5).forEach((element) => print("consuming $element"));
  print('\n***syncGenerators3.1***\n');
  var veryLongListSize = 1000000;
  var veryLongList = List.generate(veryLongListSize, (index) => index + 101);
  Iterable<int> listGenerator() sync* {
    for (var i in veryLongList) {
      // print('number $i');
      yield i;
    }
  }
  var generatedList = listGenerator();
  print('\nTake 5:\n');
  generatedList.take(5).forEach((num) => print(num));
  print('\nSkip 5 take 3:\n');
  generatedList.skip(5).take(3).forEach((num) => print(num));
  print('\nSkip while number < 103: \n');
  generatedList
      .skipWhile((num) => num < 103)
      .take(3)
      .forEach((num) => print(num));
  print('\nTake while number <= 105: \n');
  generatedList.takeWhile((num) => num <= 105).forEach((num) => print(num));
  print('\nSkip while number < 103: \n');

  print('\n***syncGenerators3.2***\n');
  var text = '''He was regarded as a wonderful reader. At church "sociables" he
   was always called upon to read poetry; and when he was through, the ladies 
   would lift up their hands and let them fall helplessly in their laps, and 
   "wall" their eyes, and shake their heads, as much as to say, "Words cannot 
   express it; it is too beautiful, TOO beautiful for this mortal earth."
   After the hymn had been sung, the Rev. Mr. Sprague turned himself into a 
   bulletin-board, and read off "notices" of meetings and societies and things 
   till it seemed that the list would stretch out to the crack of doom -- a queer 
   custom which is still kept up in America, even in cities, away here in this
   age of abundant newspapers. Often, the less there is to justify a traditional
   custom, the harder it is to get rid of it.''';

  Iterable<String> getTextLines() sync* {
    var lines = text.split('\n');
    for (var line in lines) {
      yield line;
    }
  }
  var textLines = getTextLines();
  print('\nTake 2:\n');
  textLines.take(2).forEach((line) => print(line));
  print('\nSkip 2 take 2:\n');
  textLines.skip(2).take(2).forEach((line) => print(line));
  print('\nSkip while line not starts with  "custom which": \n');
  textLines
      .skipWhile((line) => !line.startsWith(RegExp("   custom which")))
      .forEach((line) => print(line));
  print('\nTake while line not starts with  "express it;": \n');
  textLines
      .takeWhile((line) => !line.startsWith(RegExp("   express it;")))
      .forEach((line) => print(line));
}
