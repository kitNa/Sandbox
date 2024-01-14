//В код про посылки из композита добавь класс Packer, который принимает продукт,
//и возвращает его запакованным. И у этого пакера будет абстрактный метод,
// который создаёт тебе коробку по заданным размерам. И может быть несколько
// конкретных реализаций пакера - один возвращает все время коробки без филлера,
// другой только с филлером, третий например для мелких объектов создаёт коробки
// без филлера, а для больших с филлером

void main() {
  Product book = Product(250, 10, 7, 1);
  CleverPacker packer = CleverPacker();
  Parcel parcel = packer.pack(book);
  print('Parcel elements:');
  for(var element in  parcel.subComponents) {
    print('- ${element.runtimeType} with weight ${element.calculateWeight()}');
  }
  print('Parcel weight is ${parcel.calculateParcelWeight()}');
  print("----------------------------");
  PackerWithFiller packer1 = PackerWithFiller();
  Parcel parcel1 = packer1.pack(book);
  print('Parcel elements:');
  for(var element in  parcel1.subComponents) {
    print('- ${element.runtimeType} with weight ${element.calculateWeight()}');
  }
  print('Parcel weight is ${parcel1.calculateParcelWeight()}');
  print("----------------------------");
  Product tv = Product(4250, 40, 70, 10);
  CleverPacker packer2 = CleverPacker();
  Parcel parcel2 = packer2.pack(tv);
  print('Parcel elements:');
  for(var element in  parcel2.subComponents) {
    print('- ${element.runtimeType} with weight ${element.calculateWeight()}');
  }
  print('Parcel weight is ${parcel2.calculateParcelWeight()}');
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
  double cardboardDensity = 0.42;

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

  double calculateParcelWeight() {
    var parcelWeight = 0.0;
    for (var subComponent in subComponents) {
      parcelWeight += subComponent.calculateWeight();
    }
    return parcelWeight;
  }
}

//abstract creator
abstract class Packer {
  Parcel createParcel(ParcelInterface product);

  Parcel pack(ParcelInterface product) {
    Parcel parcel = createParcel(product);
    parcel.subComponents.add(product);
    parcel.subComponents.add(parcel);
    return parcel;
  }
}

//concrete creator
class PackerWithFiller extends Packer {
  //factory method
  @override
  Parcel createParcel(ParcelInterface product) {
    ParcelWithFiller parcelWithFiller = ParcelWithFiller(
        product.depth + 2, product.height + 2, product.width + 2);
    return parcelWithFiller;
  }
}

//concrete creator
class SimplePacker extends Packer {
  //factory method
  @override
  Parcel createParcel(ParcelInterface product) {
    SimpleParcel simpleParcel =
        SimpleParcel(product.depth + 2, product.height + 2, product.width + 2);
    return simpleParcel;
  }
}

//concrete creator
class CleverPacker extends Packer {
  //factory method
  @override
  Parcel createParcel(ParcelInterface product) {
    Parcel packaging;
    if (product.depth > 50 || product.height > 50 || product.width > 50) {
      packaging = ParcelWithFiller(
          product.depth + 2, product.height + 2, product.width + 2);
    } else {
      packaging = SimpleParcel(
          product.depth + 2, product.height + 2, product.width + 2);
    }
    return packaging;
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
