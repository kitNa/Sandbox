void main() {
  // https://dart.dev/language/records

  positionalRecords();
  namedRecords();
}

void positionalRecords() {
  // NOTE: in following exercises don't use "var" keyword, use explicit types everywhere instead.

  // 1. Create two functions - rnd2dPoint and rnd3dPoint. They should return a random 2d and 3d point respectively.
  // They should receive 2 positional records as arguments: minPoint and maxPoint. Function should generate
  // new point coordinates between minPoint and maxPoint, and return it as a positional record.
  // And calculate distance between two 2d points, and between two 3d points.
  // Use Random class from dart:math for generating random numbers.

  // 2. Create a function that generates random funny nicknames. It should generate it by
  // randomly choosing first part from the list of funny adjectives, and second part from the list of funny nouns.
  // var funnyAdjectives = ['happy', 'funny', 'silly', 'crazy', 'sleepy', 'hungry', 'angry'];
  // var funnyNouns = ['dog', 'cat', 'bird', 'fish', 'turtle', 'hamster', 'rabbit'];
  // Couple of funny nicknames: "funny rabbit", "hungry dog", "crazy cat", "sleepy bird", etc.
  // Function should return result nickname as a positional record.
  // Print ten random funny nicknames.
}

void namedRecords() {
  // 1. Create variants of functions from two previous tasks "positionalRecords", but use named records instead of
  // positional records.

  // 2. Create a function that reads and parses "recipes.txt" file, and returns you the recipe for the dish you specify.
  // So it should receive a dish name as a string argument, and return list of ingredients as a list of named records.
  // E.g. for "pizza" it should return response like this:
  // [
  //   ('water', 100),
  //   ('sugar', 50),
  //   ('salt', 10),
  //   ('flour', 200),
  //   ('yeast', 5),
  // ]
}
