import 'dart:math' as math;

void main() {
  // https://dart.dev/language/patterns#destructuring

  // The term "destructuring" sounds weird and complicated at first glance, but it's very simple thing in practice.
  // It means a process of breaking a data structure down into smaller parts, and assigning them to variables.

  multipleAssignments();
}

void multipleAssignments() {
  // 1. You're the captain of the space ship. You need to plan your route to the nearest planet. The path is defined
  // as a list of 3d coordinates. Each coordinate is a list of 3 numbers: [x, y, z].
  var path = [
    [-1, 10, 10],
    [21, 20, 17],
    [9, 3, 4],
    [0, 0, 0],
    [5, 8, 7],
  ];
  // Your task is to calculate how much fuel you need to reach the destination. Fuel consumption is defined as a
  var fuelConsumption = 0.1;

  // Distance between two 3d points can be calculated as (or just google for "distance between two points in 3d"):
  // https://www.engineeringtoolbox.com/distance-relationship-between-two-points-d_1854.html

  // Use destructuring to assign each coordinate to a variable.
  // var [x1, y1, z1] = path[i];
  print('\n***multipleAssignments1***\n');
  var routeLength = 0.0;
  for (int i = 0; i < path.length - 1; i++) {
    var [x1, y1, z1] = path[i];
    var [x2, y2, z2] = path[i + 1];
    var distance = getDistanceBetween3dPoints([x1, y1, z1], [x2, y2, z2]);
    routeLength += distance;
  }
  var fuelForRoute = routeLength * fuelConsumption;
  print('liters of fuel, which will be spent to overcome the indicated path:'
      ' ${fuelForRoute.toStringAsPrecision(3)}');

  // 2. Print the path from previous task along with fuel consumed in each point:
  // (1) [-1, 10, 10] - 0.0
  // (2) [21, 20, 17] - 30.5
  // (3) [9, 3, 4] - 41.3
  // ....
  // For this use destructuring combined with multiple assignment. Something like:
  // var (fuel, [x, y, z]) = (calcFuel(), path[i]);
  // NOTE: this is just for exercise sake, in real life it's better to split this into two separate statements:
  // var fuel = calcFuel(pathPrev, path[i]);
  // var [x, y, z] = path[i];
  print('\n***multipleAssignments2***\n');
  routeLength = 0.0;
  var levelOfFuelConsumption = 0.0;
  for (int i = 0; i < path.length - 1; i++) {
    if (i == 0) {
      var [x, y, z] = path[i];
      print('(${i + 1}) ${[x, y, z]} - $levelOfFuelConsumption');
    }
    var [x1, y1, z1] = path[i];
    var [x2, y2, z2] = path[i + 1];
    var distance = getDistanceBetween3dPoints([x1, y1, z1], [x2, y2, z2]);
    routeLength += distance;
    levelOfFuelConsumption = routeLength * fuelConsumption;
    var (fule, [x, y, z]) = (levelOfFuelConsumption, path[i + 1]);
    print('(${i + 2}) ${[x, y, z]} - ${fule.toStringAsPrecision(2)}');
  }
}

double getDistanceBetween3dPoints(List point1, List point2) {
  var distance = math.sqrt(math.pow(point1[0] - point2[0], 2) +
      math.pow(point1[1] - point2[1], 2) +
      math.pow(point1[2] - point2[2], 2));
  return distance;
}
