void main() {}

enum Silhouette { slim, regular, loose }

class Client {
  String fullName;
  String size = 's';
  int waistCircumference;
  int hipCircumference;
  int chestCircumference;
  int waistToHipsDistance;

  Client(
      {required this.fullName,
      required this.waistCircumference,
      required this.hipCircumference,
      required this.size,
      required this.chestCircumference,
      required this.waistToHipsDistance});

  String calculateSize() {
    var chestHalfGirth = (this.chestCircumference / 2).round().toInt();
    if (80 <= chestHalfGirth && chestHalfGirth < 90) {
      return 's';
    } else if ((91 <= chestHalfGirth && chestHalfGirth < 96)) {
      return 'm';
    } else if ((96 <= chestHalfGirth && chestHalfGirth < 100)) {
      return 'l';
    } else {
      throw Exception(
          'Нетипова фігура. Допустимий обхват грудей має бути в межах 80-100 см');
    }
  }
}

class Skirt {
  final Client client;

  // int waistCircumference;
  // int hipCircumference;
  // int waistToHipsDistance;
  //String size;
  int waistWidth = (client.waistCircumference / 2).round().toInt();
  int hipWidth = 0;
  int length = 0;
  int _increaseInWaist = 0;
  int _increaseInHip = 0;
  String _size = client.getSize;
  String? silhouette;

  Skirt(this.client, this.silhouette);

  set size(String size) => _size = client.size;

  int get increaseInWaist {
    switch (silhouette) {
      case Silhouette.slim:
        return 1;
      case Silhouette.regular:
        return 1;
      case Silhouette.loose:
        return 2;
    }
  }

  void printSkirt() {
    var pictureHipWidth = (this.hipWidth + this._increaseInHip) / 2;
    var pictureWaistWidth = (this.waistWidth + this._increaseInWaist) / 2;
    var difference = pictureHipWidth - pictureWaistWidth;
    var incrementForWidth =
        (difference / client.waistToHipsDistance).round().toInt();
    var pictureLength = this.length;
    var spaces = difference / 2;
    var filling = pictureWaistWidth / 2;
    while (spaces >= 0) {
      for (var i = 0; i < client.waistToHipsDistance; i++) {
        for (var j = 0; j < spaces; j++) {
          print(' ');
        }
        for (var j = 0; j < filling; j++) {
          print('*');
        }
        spaces -= incrementForWidth;
        filling += incrementForWidth;
      }
    }
    for (var i = 0; i < this.length - client.waistToHipsDistance; i++) {
      for (var j = 0; j < pictureHipWidth; j++) {
        print('*');
      }
    }
  }
}
