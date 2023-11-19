void main() {
  Client client = Client('Katya Nahorna', 32, 42);
  TypicalFigure figure = TypicalFigure(42);
  client.size = figure.size;
  print(client);
}

class TypicalFigure {
  final int size;

  TypicalFigure(this.size);

  int get waistCircumference {
    switch (size) {
      case 42:
        return 65;
      case 46:
        return 69;
      case 48:
        return 73;
      default:
        throw Exception('Not a typical figure. The size must correspond'
            ' to the permissible value: 42, 46, 48');
    }
  }

  int get hipCircumference {
    switch (size) {
      case 42:
        return 92;
      case 46:
        return 96;
      case 48:
        return 100;
      default:
        throw Exception('Not a typical figure. The size must correspond'
            ' to the permissible value: 42, 46, 48');
    }
  }

  int get chestCircumference {
    switch (size) {
      case 42:
        return 84;
      case 46:
        return 90;
      case 48:
        return 96;
      default:
        throw Exception('Not a typical figure. The size must correspond'
            ' to the permissible value: 42, 46, 48');
    }
  }
}

class Client extends TypicalFigure {
  String fullName;
  int size;
  int age;

  Client(this.fullName, this.age, this.size) : super(size);

  @override
  String toString(){
    return ('Client data:\n'
        'full name - $fullName\n'
        'age - $age\n'
        'waist circumference - $waistCircumference\n'
        'hip circumference - $hipCircumference\n'
        'chest circumference - $chestCircumference');
  }
}
