import 'dart:math' as math;
import 'dart:io';

void main() {
  // https://dart.dev/language/records
  //dart:math

  namedRecords();
}

void namedRecords() async {
  // 1. Create variants of functions from two previous tasks "positionalRecords", but use named records instead of
  // positional records.
  print('\n***namedRecords1***\n');
  ({int x, int y}) min2dPoint = (x: 15, y: 20);
  ({int x, int y}) max2dPoint = (x: 20, y: 40);
  ({int x, int y}) rn2dPoint1 = getRnd2dPoint(min2dPoint, max2dPoint);
  ({int x, int y}) rn2dPoint2 = getRnd2dPoint(min2dPoint, max2dPoint);
  print('Перша 2d точка: $rn2dPoint1');
  print('Друга 2d точка: $rn2dPoint2');
  print('Відстань між 2d точками: ${getDistanceBetween2dPoints(rn2dPoint1, rn2dPoint2)}');
  print('\n');
  ({int x, int y, int z}) min3dPoint = (x: 15, y: 20, z: 30);
  ({int x, int y, int z}) max3dPoint = (x: 20, y: 40, z: 80);
  ({int x, int y, int z}) rn3dPoint1 = getRnd3dPoint(min3dPoint, max3dPoint);
  ({int x, int y, int z}) rn3dPoint2 = getRnd3dPoint(min3dPoint, max3dPoint);
  print('Перша 3d точка: $rn3dPoint1');
  print('Друга 3d точка: $rn3dPoint2');
  print('Відстань між 3d точками: ${getDistanceBetween3dPoints(rn3dPoint1, rn3dPoint2)}');

  var rnPoibt = getRnd3dPoint((x: 15, y: 20, z: 30), (x: 20, y: 40, z: 80));

  // 2. Create a function that reads and parses "02_recipes.txt" file, and returns you the recipe for the dish you specify.
  // So it should receive a dish name as a string argument, and return list of ingredients as a list of named records.
  // E.g. for "pizza" it should return response like this:
  // [
  //   ('water', 100),
  //   ('sugar', 50),
  //   ('salt', 10),
  //   ('flour', 200),
  //   ('yeast', 5),
  // ]
  print('\n***namedRecords2***\n');
  String recipe = 'Scrambled eggs';
  print(await getRecipe(recipe));
}

Future<List<(String ingredient, double amount)>> getRecipe(String dish) async {
  //(String  ingredient, int quantity)recipe;
  final List<(String ingredient, double amount)> recipe = [];
  var recipesFile =
      File('lib/src/exercises/004_builtin_types/02_recipes.txt');
  var recipeLines = (await recipesFile.readAsLines())
      .where((line) => line.isNotEmpty)
      .toList();
  for (int i = 0; i < recipeLines.length; i++) {
    if (recipeLines[i] == dish) {
      i++;
      while (!recipeLines[i].contains('----')) {
        final parts = recipeLines[i].split(' : ');
        final name = parts[0];
        final amount = double.parse(parts[1]);
        recipe.add((name, amount));
        i++;
      }
    }
  }
  return recipe;
}

({int x, int y}) getRnd2dPoint(({int x, int y}) minPoint,
    ({int x, int y}) maxPoint) {
  var xValue = math.Random().nextInt(maxPoint.x - minPoint.x) + minPoint.x;
  var yValue = math.Random().nextInt(maxPoint.y - minPoint.y) + minPoint.y;
  ({int x, int y}) newPoint = (x: xValue, y: yValue);
  return newPoint;
}

double getDistanceBetween2dPoints(({int x, int y}) minPoint,
    ({int x, int y}) maxPoint) {
  var distance = math.sqrt(math.pow(maxPoint.x - minPoint.x, 2) +
      math.pow(maxPoint.y - minPoint.y, 2));
  return distance;
}

({int x, int y, int z}) getRnd3dPoint(({int x, int y, int z}) minPoint,
    ({int x, int y, int z}) maxPoint) {
  var xValue = math.Random().nextInt(maxPoint.x - minPoint.x) + minPoint.x;
  var yValue = math.Random().nextInt(maxPoint.y - minPoint.y) + minPoint.y;
  var zValue = math.Random().nextInt(maxPoint.z - minPoint.z) + minPoint.z;
  ({int x, int y, int z}) newPoint = (x: xValue, y: yValue, z: zValue);
  return newPoint;
}

double getDistanceBetween3dPoints(({int x, int y, int z}) minPoint,
    ({int x, int y, int z}) maxPoint) {
  var distance = math.sqrt(math.pow(maxPoint.x - minPoint.x, 2) +
      math.pow(maxPoint.y - minPoint.y, 2) +
      math.pow(maxPoint.z - minPoint.z, 2));
  return distance;
}
