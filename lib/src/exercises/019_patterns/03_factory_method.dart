//В код про посылки из композита добавь класс Packer, который принимает продукт,
//и возвращает его запакованным. И у этого пакера будет абстрактный метод,
// который создаёт тебе коробку по заданным размерам. И может быть несколько
// конкретных реализаций пакера - один возвращает все время коробки без филлера,
// другой только с филлером, третий например для мелких объектов создаёт коробки
// без филлера, а для больших с филлером

import 'package:sandbox/src/exercises/019_patterns/01_composite.dart';

void main() {
  Product book = Product(1, 7, 10, 350);
  CleverPacker packer = CleverPacker();
  Parcel parcel = packer.pack(book);
  print('Parcel elements:');
  for (var element in parcel.subComponents) {
    print('- ${element.runtimeType} with weight ${element.weight}');
  }
  print('- ${parcel.runtimeType} with weight ${parcel.weight}');
  print('Parcel weight is ${parcel.totalWeight}');
  print("----------------------------");
  PackerWithFiller packer1 = PackerWithFiller();
  Parcel parcel1 = packer1.pack(book);
  print('Parcel elements:');
  for (var element in parcel1.subComponents) {
    print('- ${element.runtimeType} with weight ${element.weight}');
  }
  print('- ${parcel1.runtimeType} with weight ${parcel1.weight}');
  print('Parcel weight is ${parcel1.totalWeight}');
  print("----------------------------");
  Product tv = Product(10, 70, 40, 6230);
  CleverPacker packer2 = CleverPacker();
  Parcel parcel2 = packer2.pack(tv);
  print('Parcel elements:');
  for (var element in parcel2.subComponents) {
    print('- ${element.runtimeType} with weight ${element.weight}');
  }
  print('- ${parcel2.runtimeType} with weight ${parcel2.weight}');
  print('Parcel weight is ${parcel2.totalWeight}');
}

//product interface
abstract interface class ParcelInterface {
  int get height;

  int get width;

  int get depth;

  double get weight;

  double get totalWeight;
}

//abstract  parcel
abstract class Parcel implements ParcelInterface {
  double cardboardDensity = 0.042;

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

  Parcel(this.depth, this.height, this.width);

  // Parcel.withComponent(ParcelInterface component)
  //     : depth = component.depth + 2,
  //       height = component.height + 2,
  //       width = component.width + 2 {
  //   subComponents.add(component);
  // }

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

  @override
  get totalWeight {
    var parcelWeight = weight;
    for (var subComponent in subComponents) {
      parcelWeight += subComponent.weight;
    }
    return parcelWeight;
  }
}

abstract class ParcelElement implements ParcelInterface{

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


//abstract creator
abstract class Packer {
  Parcel createParcel(ParcelInterface product);

  Parcel pack(ParcelInterface component) {
    Parcel parcel = createParcel(component);
    parcel.subComponents.add(component);
    return parcel;
  }
}

//concrete creator
class PackerWithFiller extends Packer {
  //factory method
  @override
  Parcel createParcel(ParcelInterface component) {
    return ParcelWithFiller.withComponent(component);
  }
}

//concrete creator
class SimplePacker extends Packer {
  //factory method
  @override
  Parcel createParcel(ParcelInterface component) {
    return SimpleParcel.withComponent(component);
  }
}

//concrete creator
class CleverPacker extends Packer {
  //factory method
  @override
  Parcel createParcel(ParcelInterface component) {
    if (component.depth > 50 || component.height > 50 || component.width > 50) {
      return ParcelWithFiller.withComponent(component);
    } else {
      return SimpleParcel.withComponent(component);
    }
  }
}

//concrete product parcel
class SimpleParcel extends Parcel {
  SimpleParcel(super.depth, super.height, super.width);

  SimpleParcel.withComponent(ParcelInterface component)
      : super(component.depth + 2, component.height + 2, component.width + 2);
}

//concrete product parcel
class ParcelWithFiller extends Parcel {
  ParcelWithFiller.empty(super.depth, super.height, super.width);

  ParcelWithFiller.withComponent(ParcelInterface component)
      : super(component.depth + 2, component.height + 2, component.width + 2);

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
