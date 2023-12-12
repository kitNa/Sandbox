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
  int firstSide;
  int secondSide;
  int thirdSide;
  int fourthSide;

  AbstractFigure(this.firstSide, this.secondSide, this.thirdSide, this.fourthSide);

  @override
  int perimeter() {
    return firstSide + secondSide + thirdSide + fourthSide;
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
