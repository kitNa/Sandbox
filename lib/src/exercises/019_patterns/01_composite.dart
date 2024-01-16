//Программа для расчета полного веса посылок для отправки автомобилем.
// Вес посылки - это вес всех коробок/упаковок + вес самого товара.
// Есть два вида коробок - обычная и с наполнителем
// (разные способы расчета веса от размеров).
// Один товар может быть запакован в много слоев
// (коробка в коробке в коробке ...). И также несколько
// посылок могут комбинироваться в одну коробку (3 коробки в коробке).

void main() {
  ParcelComponent book = Product(250, 10, 7, 1);
  ParcelComponent boxForBook = SimpleParcel(12, 15, 10);
  ParcelComposite innerBox = ParcelWithFiller(25, 18, 20);
  innerBox.addItem(book);
  innerBox.addItem(boxForBook);
  ParcelComponent outerBox = SimpleParcel(30, 20, 25);
  ParcelComposite parcel = SimpleParcel(35, 25, 30);
  parcel.addItem(outerBox);
  print('Parcel weight: ${parcel.totalWeight} gm');
}

//Component
abstract interface class ParcelComponent {
  int get height;

  int get width;

  int get depth;

  double get weight;

  double get totalWeight;
}

//Composite
abstract class ParcelComposite implements ParcelComponent {
  static const double cardboardDensity = 0.42;

  @override
  int depth;

  @override
  int height;

  @override
  int width;

  int get boxArea {
    return 2 * (height * width + height * depth + depth * width);
  }

  @override
  double get weight {
    return boxArea * cardboardDensity;
  }

  ParcelComposite(this.depth, this.height, this.width);

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
  double get totalWeight {
    var parcelWeight = weight;
    for (ParcelComponent subComponent in subComponents) {
      parcelWeight += subComponent.weight;
    }
    return parcelWeight;
  }
}

//Leaf
abstract class ParcelElement implements ParcelComponent {

  @override
  final int height;

  @override
  final int width;

  @override
  final int depth;

  @override
  final double weight;

  ParcelElement(this.height, this.width, this.depth, this.weight);
}

class SimpleParcel extends ParcelComposite {
  SimpleParcel(super.depth, super.height, super.width);
}

class ParcelWithFiller extends ParcelComposite {
  ParcelWithFiller(super.depth, super.height, super.width);

  static const double fillerWeightPerUnitVolume = 0.001;

  double get fillerWeight {
    return height * width * depth * fillerWeightPerUnitVolume;
  }

  @override
  double get weight {
    return super.weight + fillerWeight;
  }
}

class Product extends ParcelElement {
  Product(super.height, super.width, super.depth, super.weight);

  @override
  double get totalWeight => weight;
}
