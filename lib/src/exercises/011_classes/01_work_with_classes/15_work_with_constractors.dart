void main() {
  Triangle triangle = Triangle(10, 20, 15);
  print('Triangle perimeter is ${triangle.perimeter()}');

  Quadrangle quadrangle = Quadrangle(10, 15, 17, 20);
  print('Quadrangle perimeter is ${quadrangle.perimeter()}');

  Square square = Square(10);
  print('Square perimeter is ${square.perimeter()}');
}

abstract interface class Figure {
  int perimeter();
}

abstract class AbstractFigure implements Figure {
  final int _firstSide;
  final int _secondSide;
  final int _thirdSide;
  final int _fourthSide;

  AbstractFigure(this._firstSide, this._secondSide, this._thirdSide, this._fourthSide);

  @override
  int perimeter() {
    return _firstSide + _secondSide + _thirdSide + _fourthSide;
  }
}

class Quadrangle extends AbstractFigure {
  Quadrangle(super.firstSide, super.secondSide, super.thirdSide, super.fourthSide);
}

class Triangle extends AbstractFigure {
  Triangle(firstSide, secondSide, thirdSide) : super(firstSide, secondSide, thirdSide, 0);
}

class Square extends AbstractFigure {
  Square(side) : super(side, side, side, side);
}
