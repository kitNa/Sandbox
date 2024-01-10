//Программа для расчета полного веса посылок для отправки автомобилем.
// Вес посылки - это вес всех коробок/упаковок + вес самого товара.
// Есть два вида коробок - обычная и с наполнителем
// (разные способы расчета веса от размеров).
// Один товар может быть запакован в много слоев
// (коробка в коробке в коробке ...). И также несколько
// посылок могут комбинироваться в одну коробку (3 коробки в коробке).

void main() {
  ParcelComponent book = Product(250, 10, 7, 1);
  ParcelComponent boxForBook = BoxWithFiller(12, 15, 10);
  Parcel innerBox = ParcelWithFiller(25, 18, 20);
  innerBox.addItem(book);
  innerBox.addItem(boxForBook);
  ParcelComponent outerBox = BoxWithFiller(30, 20, 25);
  Parcel parcel = SimpleParcel(35, 25, 30);
  parcel.addItem(outerBox);
  print('Parcel weight: ${parcel.calculateWeight()}');
}

//Component
abstract interface class ParcelComponent {
  int get height;

  int get width;

  int get depth;

  double calculateWeight();
}

//Composite
abstract class Parcel implements ParcelComponent {
  @override
  int depth;

  @override
  int height;

  @override
  int width;

  Parcel(this.depth, this.height, this.width);

  List<ParcelComponent> subComponents = <ParcelComponent>[];

  addItem(ParcelComponent subComponent) {
    subComponents.add(subComponent);
  }

  removeItem(subComponent) {
    if (subComponents.contains(subComponent)) {
      subComponents.remove(subComponent);
    } else {
      throw Exception('This parcel is missing the specified item');
    }
  }

  @override
  double calculateWeight() {
    var parcelWeight = 0.0;
    for (ParcelComponent subComponent in subComponents) {
      parcelWeight += subComponent.calculateWeight();
    }
    return parcelWeight;
  }
}

//Leaf
abstract class ParcelElement implements ParcelComponent {
  static const double cardboardDensity = 0.42;

  @override
  final int height;

  @override
  final int width;

  @override
  final int depth;

  ParcelElement(this.height, this.width, this.depth);

  int get boxArea {
    return 2 * (height * width + height * depth + depth * width);
  }

  @override
  double calculateWeight() {
    return boxArea * cardboardDensity;
  }
}

class SimpleParcel extends Parcel {
  SimpleParcel(super.depth, super.height, super.width);
}

class ParcelWithFiller extends Parcel {
  ParcelWithFiller(super.depth, super.height, super.width);

  static const double fillerWeightPerUnitVolume = 0.001;

  double get fillerWeight {
    return height * width * depth * fillerWeightPerUnitVolume;
  }

  @override
  double calculateWeight() {
    return super.calculateWeight() + fillerWeight;
  }
}

class SimpleBox extends ParcelElement {
  SimpleBox(super.height, super.width, super.depth);
}

class BoxWithFiller extends ParcelElement {
  static const double fillerWeightPerUnitVolume = 0.001;

  double get fillerWeight {
    return height * width * depth * fillerWeightPerUnitVolume;
  }

  BoxWithFiller(super.height, super.width, super.depth);

  @override
  double calculateWeight() {
    return super.calculateWeight() + fillerWeight;
  }
}

class Product extends ParcelElement {
  double productWeight;

  Product(this.productWeight, super.height, super.width, super.depth);

  @override
  double calculateWeight() {
    return productWeight;
  }
}
