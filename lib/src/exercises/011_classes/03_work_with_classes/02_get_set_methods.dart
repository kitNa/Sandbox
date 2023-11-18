void main() {
  Client client = Client(
      fullName: 'Katya Nahorna',
      waistCircumference: 65,
      hipCircumference: 94,
      chestCircumference: 84,
      waistToHipsDistance: 18);

  print('Client size is ${client.size.toUpperCase()}');

  Skirt skirt = Skirt(client, Silhouette.slim, 50);
  skirt.printSkirt();
}

enum Silhouette { slim, regular, loose }

class Client {
  final String fullName;
  final int waistCircumference;
  final int hipCircumference;
  final int chestCircumference;
  final int waistToHipsDistance;

  Client(
      {required this.fullName,
      required this.waistCircumference,
      required this.hipCircumference,
      required this.chestCircumference,
      required this.waistToHipsDistance});

  String get size {
    if (80 <= chestCircumference && chestCircumference < 90) {
      return 's';
    } else if ((91 <= chestCircumference && chestCircumference < 96)) {
      return 'm';
    } else if ((96 <= chestCircumference && chestCircumference < 100)) {
      return 'l';
    } else {
      throw Exception('Atypical figure. The permissible chest girth '
          'should be within the limits 80-100 sm');
    }
  }
}

class Skirt {
  final Client client;
  final Silhouette silhouette;
  final int length;
  final int _waistWidth;
  final int _hipWidth;

  Skirt(this.client, this.silhouette, this.length)
      : _waistWidth = (client.waistCircumference / 2).round().toInt(),
        _hipWidth = (client.hipCircumference / 2).round().toInt() {
    if (!Silhouette.values.contains(silhouette)) {
      throw Exception(
          'The entered silhouette value is not in the database. Enter '
          'one of the valid values: slim, regular, loose');
    }
  }

  int get waistIncrease {
    switch (silhouette) {
      case Silhouette.slim:
        return 0;
      case Silhouette.regular:
        return 1;
      case Silhouette.loose:
        return 2;
      default:
        throw Exception('The entered silat value is not in the database. Enter '
            'one of the valid values: slim, regular, loose');
    }
  }

  set waistIncrease(int desirableWaistIncrease) =>
      waistIncrease = desirableWaistIncrease;

  int get hipIncrease {
    switch (silhouette) {
      case Silhouette.slim:
        return 1;
      case Silhouette.regular:
        return 2;
      case Silhouette.loose:
        return 3;
      default:
        throw Exception('The entered silat value is not in the database. Enter '
            'one of the valid values: slim, regular, loose');
    }
  }

  set hipIncrease(int desirableHipIncrease) =>
      waistIncrease = desirableHipIncrease;

  void printSkirt() {
    var pictureHipWidth = _hipWidth + hipIncrease;
    var pictureWaistWidth = _waistWidth + waistIncrease;
    var widthDifference = pictureHipWidth - pictureWaistWidth;
    var incrementForWidth =
        (widthDifference / client.waistToHipsDistance).round().toInt();
    var spaces = 0;
    var filling = 0;
    while (spaces >= 0) {
      spaces = widthDifference ~/ 2;
      filling = pictureWaistWidth ~/ 2;
      for (var i = 0; i < client.waistToHipsDistance; i++) {
        print(' ' * spaces + '*' * filling);
        spaces -= incrementForWidth;
        filling += incrementForWidth;
      }
    }
    for (var i = 0; i < length - client.waistToHipsDistance; i++) {
      print('*' * pictureHipWidth);
    }
  }
}
