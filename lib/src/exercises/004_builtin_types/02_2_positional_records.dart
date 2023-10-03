import 'dart:math' as math;

void main() {
  // https://dart.dev/language/records
  //dart:math

  positionalRecords();
}

void positionalRecords() {
  // NOTE: in following exercises don't use "var" keyword, use explicit types everywhere instead.

  // 1. Create two functions - rnd2dPoint and rnd3dPoint. They should return a random 2d and 3d point respectively.
  // They should receive 2 positional records as arguments: minPoint and maxPoint. Function should generate
  // new point coordinates between minPoint and maxPoint, and return it as a positional record.
  // And calculate distance between two 2d points, and between two 3d points.
  // Use Random class from dart:math for generating random numbers.
  print('\n***positionalRecords1***\n');
  (int x, int y) min2dPoint = (15, 20);
  (int x, int y) max2dPoint = (20, 40);
  (int x, int y) rn2dPoint1 = getRnd2dPoint(min2dPoint, max2dPoint);
  (int x, int y) rn2dPoint2 = getRnd2dPoint(min2dPoint, max2dPoint);
  print('Перша 2d точка: $rn2dPoint1');
  print('Друга 2d точка: $rn2dPoint2');
  print(
      'Відстань між 2d точками: ${getDistanceBetween2dPoints(rn2dPoint1, rn2dPoint2)}');
  print('\n');
  (int x, int y, int z) min3dPoint = (15, 20, 30);
  (int x, int y, int z) max3dPoint = (20, 40, 80);
  (int x, int y, int z) rn3dPoint1 = getRnd3dPoint(min3dPoint, max3dPoint);
  (int x, int y, int z) rn3dPoint2 = getRnd3dPoint(min3dPoint, max3dPoint);
  print('Перша 3d точка: $rn3dPoint1');
  print('Друга 3d точка: $rn3dPoint2');
  print(
      'Відстань між 3d точками: ${getDistanceBetween3dPoints(rn3dPoint1, rn3dPoint2)}');

  // 2. Create a function that generates random funny nicknames. It should generate it by
  // randomly choosing first part from the list of funny adjectives, and second part from the list of funny nouns.
  // var funnyAdjectives = ['happy', 'funny', 'silly', 'crazy', 'sleepy', 'hungry', 'angry'];
  // var funnyNouns = ['dog', 'cat', 'bird', 'fish', 'turtle', 'hamster', 'rabbit'];
  // Couple of funny nicknames: "funny rabbit", "hungry dog", "crazy cat", "sleepy bird", etc.
  // Function should return result nickname as a positional record.
  // Print ten random funny nicknames.

  print('\n***positionalRecords2***\n');
  var funnyAdjectives = [
    'happy',
    'funny',
    'silly',
    'crazy',
    'sleepy',
    'hungry',
    'angry'
  ];
  var funnyNouns = [
    'dog',
    'cat',
    'bird',
    'fish',
    'turtle',
    'hamster',
    'rabbit'
  ];
  int numberOfFunnyNicknames = 10;
  for (int i = 0; i < numberOfFunnyNicknames; i++) {
    (String, String) nickname = getFunnyNickname(funnyAdjectives, funnyNouns);
    print('${nickname.$1} ${nickname.$2}');
  }
}

(int x, int y) getRnd2dPoint((int x, int y) minPoint, (int x, int y) maxPoint) {
  var x = math.Random().nextInt(maxPoint.$1 - minPoint.$1) + minPoint.$1;
  var y = math.Random().nextInt(maxPoint.$2 - minPoint.$2) + minPoint.$2;
  return (x, y);
}

double getDistanceBetween2dPoints(
    (int x, int y) minPoint, (int x, int y) maxPoint) {
  var distance = math.sqrt(math.pow(maxPoint.$1 - minPoint.$1, 2) +
      math.pow(maxPoint.$2 - minPoint.$2, 2));
  return distance;
}

(int x, int y, int z) getRnd3dPoint(
    (int x, int y, int z) minPoint, (int x, int y, int z) maxPoint) {
  var x = math.Random().nextInt(maxPoint.$1 - minPoint.$1) + minPoint.$1;
  var y = math.Random().nextInt(maxPoint.$2 - minPoint.$2) + minPoint.$2;
  var z = math.Random().nextInt(maxPoint.$3 - minPoint.$3) + minPoint.$3;
  return (x, y, z);
}

double getDistanceBetween3dPoints(
    (int x, int y, int z) minPoint, (int x, int y, int z) maxPoint) {
  var distance = math.sqrt(math.pow(maxPoint.$1 - minPoint.$1, 2) +
      math.pow(maxPoint.$2 - minPoint.$2, 2) +
      math.pow(maxPoint.$3 - minPoint.$3, 2));
  return distance;
}

(String, String) getFunnyNickname(List funnyAdjectives, List funnyNouns) {
  int indexOfRnFunnyAdjectives = math.Random().nextInt(funnyAdjectives.length);
  int indexOfRnFunnyNouns = math.Random().nextInt(funnyNouns.length);
  String rnFunnyAdjectives = funnyAdjectives[indexOfRnFunnyAdjectives];
  String rnFunnyNouns = funnyNouns[indexOfRnFunnyNouns];
  (String, String) funnyNickname = (rnFunnyAdjectives, rnFunnyNouns);
  return funnyNickname;
}
