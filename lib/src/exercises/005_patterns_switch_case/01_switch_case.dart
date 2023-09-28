import 'dart:io';
import 'dart:math';

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

  var mazeFile = File('lib/src/exercises/005_patterns_switch_case/the-great-maze.txt');
  var mazeLines = await mazeFile.readAsLines();
  var maze = mazeLines.map((line) => line.split('')).toList();

  // 1. Emulate several warriors, they need to go through the maze and reach the exit. Print their paths.
  var rnd = Random();


  // 2. You're the judge of the competition. You have to choose the winner.
  // Find the mightiest warrior, who reaches the exit with the highest score. The contestant who doesn't reach the
  // exit is disqualified.
}
