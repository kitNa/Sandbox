//В код про посылки из композита добавь класс Packer, который принимает продукт,
//и возвращает его запакованным. И у этого пакера будет абстрактный метод,
// который создаёт тебе коробку по заданным размерам. И может быть несколько
// конкретных реализаций пакера - один возвращает все время коробки без филлера,
// другой только с филлером, третий например для мелких объектов создаёт коробки
// без филлера, а для больших с филлером

void main() {
  Product book = Product(250, 10, 7, 1);
  CleverPacker parcel = CleverPacker(book);
  print("Parcel weight is ${parcel.calculateWeight()} gram");
  print("Parcel elements:");
  for (var element in parcel.subComponents) {
    print("- ${element.runtimeType} with width ${element.width},"
        " height ${element.height} and depth  ${element.depth}");
  }
  print("----------------------------");
  PackerWithFiller parcel1 = PackerWithFiller(book);
  print("Parcel weight is ${parcel1.calculateWeight()} gram");
  print("Parcel elements:");
  for (var element in parcel1.subComponents) {
    print("- ${element.runtimeType} with width ${element.width},"
        " height ${element.height} and depth  ${element.depth}");
  }
  print("----------------------------");
  Product tv = Product(4250, 40, 70, 10);
  CleverPacker parcel2 = CleverPacker(tv);
  print("Parcel weight is ${parcel2.calculateWeight()} gram");
  print("Parcel elements:");
  for (var element in parcel2.subComponents) {
    print("- ${element.runtimeType} with width ${element.width},"
        " height ${element.height} and depth  ${element.depth}");
  }

}

//product interface
abstract interface class ParcelInterface {
  int get height;

  int get width;

  int get depth;

  double calculateWeight();
}

//abstract product parcel
abstract class Parcel implements ParcelInterface {
  static const double cardboardDensity = 0.42;

  @override
  int depth;

  @override
  int height;

  @override
  int width;

  Parcel(this.depth, this.height, this.width);

  List<ParcelInterface> subComponents = <ParcelInterface>[];

  addItem(ParcelInterface subComponent) {
    subComponents.add(subComponent);
  }

  removeItem(subComponent) {
    if (subComponents.contains(subComponent)) {
      subComponents.remove(subComponent);
    } else {
      throw Exception('This parcel is missing the specified item');
    }
  }

  int get boxArea {
    return 2 * (height * width + height * depth + depth * width);
  }

  @override
  double calculateWeight() {
    return boxArea * cardboardDensity;
  }
}

//abstract creator
abstract class Packer {
  int depth;

  int height;

  int width;

  Product product;

  Packer(this.product)
      : depth = product.depth + 2,
        height = product.height + 2,
        width = product.width + 2 {
    packUp();
  }

  List<ParcelInterface> subComponents = <ParcelInterface>[];

  //factory method
  void packUp();

  double calculateWeight() {
    var parcelWeight = 0.0;
    for (ParcelInterface subComponent in subComponents) {
      parcelWeight += subComponent.calculateWeight();
    }
    return parcelWeight;
  }
}

//concrete creator
class PackerWithFiller extends Packer {
  PackerWithFiller(super.product);

  //factory method
  @override
  void packUp() {
    super.subComponents = [];
    ParcelWithFiller parcelWithFiller = ParcelWithFiller(depth, height, width);
    super.subComponents.add(product);
    super.subComponents.add(parcelWithFiller);
  }
}

//concrete creator
class SimplePacker extends Packer {
  SimplePacker(super.product);

  //factory method
  @override
  void packUp() {
    super.subComponents = [];
    SimpleParcel parcelWithFiller = SimpleParcel(depth, height, width);
    super.subComponents.add(product);
    super.subComponents.add(parcelWithFiller);
  }
}

//concrete creator
class CleverPacker extends Packer {
  CleverPacker(super.product);

  //factory method
  @override
  void packUp() {
    super.subComponents = [];
    ParcelInterface packaging;
    if (product.depth > 50 || product.height > 50 || product.width > 50) {
      packaging = ParcelWithFiller(depth, height, width);
    } else {
      packaging = SimpleParcel(depth, height, width);
    }
    super.subComponents.add(product);
    super.subComponents.add(packaging);
  }
}

//concrete product parcel
class SimpleParcel extends Parcel {
  SimpleParcel(super.depth, super.height, super.width);
}

//concrete product parcel
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

class Product implements ParcelInterface {
  double productWeight;

  static const double cardboardDensity = 0.42;

  @override
  final int height;

  @override
  final int width;

  @override
  final int depth;

  Product(this.productWeight, this.height, this.width, this.depth);

  @override
  double calculateWeight() {
    return productWeight;
  }
}
