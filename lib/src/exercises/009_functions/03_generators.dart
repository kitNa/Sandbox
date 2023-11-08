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
  // Call it, and iterate over the result.
  // NOTE that generator function is lazy. It will not generate value until
  // you request it.

  // 2. Create a sync generator function which will *INFINITELY* generate random
  // funny names from combining random elements of two lists "funnyPrefix"
  // and "funnySuffix". Also on each iteration print the name in generator.
  // Call it 10 times and note that it is lazy and won't generate anything
  // until you request it.

  // 3. Create a sync generator function which will return lines from list
  // (in real world, this could be a file). And on each iteration print
  // "reading line $line".
  // Call it and limit the iterator by using any combination of
  // skip/take/skipWhile/takeWhile methods. For example,
  // take while !line.startsWith("desired prefix")

  // EXAMPLE:
  var veryLongListSize = 100000; // imagine this is a huge file, like 100Gb
  var veryLongList = List.generate(veryLongListSize, (index) => index);
  Iterable<int> syncGenerator() sync* {
    for (var i in veryLongList) {
      // in real life, here we will be reading line from file
      print("generating number $i");
      yield i;
    }
  }
  var generatedIterable = syncGenerator();
  generatedIterable.take(5).forEach((element) => print("consuming $element"));
}
