import 'dart:io';
import 'dart:math';

import 'package:sandbox/src/exercises/001_basics_variables/variables.dart';

Future<void> main() async {
  // https://dart.dev/language/branches#switch-statements
  switchCase();
}

Future<void> switchCase() async {
  // Let's play a game, shall we?
  // In the great desert of Sandara there is the Secret Maze of Trials. Only the mightiest of warriors of the tribe
  // Wamba can enter it. And every year they send their best warriors to compete in the maze, to choose the best of the
  // best.

  // The Secret Maze of Trials is defined in a form of a matrix. "." is a path, "#" is a wall, and numbers are x10
  // bonuses. E.g. number "3" means that if you step on it, you get +30 points.
  // Traps are defined as "T" and they subtract -5 points from your score.

  // Maze entrance is always at [1, 1] (left top corner) and exit at [n-2, n-2] (right bottom corner).
  // Each move costs one point.
  // Each contestant's path is defined as a list of moves: "u" - up, "d" - down, "l" - left, "r" - right.

  var mazeFile =
      File('lib/src/exercises/005_patterns_switch_case/the-great-maze.txt');
  var mazeLines = await mazeFile.readAsLines();
  var maze = mazeLines
      .where((line) => line.isNotEmpty)
      .map((line) => line.split(''))
      .toList();
  //print(maze);

  // 1. Emulate several warriors, they need to go through the maze and reach the exit. Print their paths.
  const multiplier = 10;
  const penalty = 5;
  const moveCost = -1;
  const path1 = 'rdddddrrrddddrrrrrrrddrrrddddrrrrrrrrrrd';
  const path2 = 'rrrdddrruurrrrrrddrrrddddrrrrrrddddddrrrrddd';
  const path3 = 'rrdddddddddddddddrrrrrrrrrrrrrrrrrrrrrrd';
  var paths = [path1, path2, path3];
  var firstPathCommands = path1.split('');
  var secondPathCommands = path2.split('');
  var thirdPathCommands = path3.split('');

  // 2. You're the judge of the competition. You have to choose the winner.
  // Find the mightiest warrior, who reaches the exit with the highest score. The contestant who doesn't reach the
  // exit is disqualified.
  //Varianr1
  print('\n***Var1***\n');
  for (var path in paths) {
    var bonus = 0;
    var posRow = 0;
    var posColumn = 0;
    var pathCommands = path.split('');
    for (var i = 0; i < pathCommands.length; i++) {
      var command = pathCommands[i];
      //print('Step i $i and maze posRow ${posRow + 1}, maze posColumn ${posColumn + 1}');
      switch (command) {
        case 'r':
          posColumn++;
        case 'l':
          posColumn--;
        case 'u':
          posRow--;
        case 'd':
          posRow++;
      }
      if (int.tryParse(maze[posRow][posColumn]) != null) {
        bonus += int.parse(maze[posRow][posColumn]) * multiplier;
      } else if (maze[posRow][posColumn] == 'T') {
        bonus -= penalty;
      } else {
        bonus -= moveCost;
      }
    }
    var exitRowPos = maze.length - 1;
    var exitColumnPos = maze[exitRowPos].length - 1;
    if (posColumn == exitColumnPos && posRow == exitRowPos) {
      print ('Вітаю! Ви вийшли із лабіринта. Ваш бонус: $bonus');
    } else {
      print('Ви заблукали!');
    }
  }
//Varianr2
  print('\n***Var2***\n');
  for (var path in paths) {
    var bonus = 0;
    var posRow = 0;
    var posColumn = 0;
    var pathCommands = path.split('');
    // var numberPattern = RegExp("[\\d]");
     var numbers = ['1', '2', '3', '4', '5', '6'];
    for (var i = 0; i < pathCommands.length; i++) {
      var mazeElement = maze[posRow][posColumn].toString();
      var command = pathCommands[i];
      //print('Step i $i and maze posRow ${posRow + 1}, maze posColumn ${posColumn + 1}');
      switch (command) {
        case 'r':
          posColumn++;
        case 'l':
          posColumn--;
        case 'u':
          posRow--;
        case 'd':
          posRow++;
      }
      switch (mazeElement) {
        case '1' || '2' || '3' || '4' || '5' || '6':
          bonus += int.parse(mazeElement) * multiplier;
        case 'T':
          bonus -= penalty;
        default:
          bonus -= moveCost;
      }
    }
    var exitRowPos = maze.length - 1;
    var exitColumnPos = maze[exitRowPos].length - 1;
    if (posColumn == exitColumnPos && posRow == exitRowPos) {
      print ('Вітаю! Ви вийшли із лабіринта. Ваш бонус: $bonus');
    } else {
      print('Ви заблукали!');
    }
  }
}
