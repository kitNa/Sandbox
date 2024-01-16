//В код про посылки из композита добавь класс Packer, который принимает продукт,
//и возвращает его запакованным. И у этого пакера будет абстрактный метод,
// который создаёт тебе коробку по заданным размерам. И может быть несколько
// конкретных реализаций пакера - один возвращает все время коробки без филлера,
// другой только с филлером, третий например для мелких объектов создаёт коробки
// без филлера, а для больших с филлером

import '01_composite.dart';

void main() {
  Packer packer = SimplePacker();
  var book = Product(0.5);
  var packedBook = packer.pack(book);
  print('Book packed into ${packedBook.runtimeType} with weight ${packedBook.totalWeight}');

  packer = PackerWithFiller();
  var tv = Product(10);
  var packedTv = packer.pack(tv);
  print('TV packed into ${packedTv.runtimeType} with weight ${packedTv.totalWeight}');

  packer = CleverPacker();
  var phone = Product(0.1);
  var packedPhone = packer.pack(phone);
  print('Phone packed into ${packedPhone.runtimeType} with weight ${packedPhone.totalWeight}');

  var phoneAndTv = packer.packMany([packedPhone, packedTv]);
  print('Phone and TV packed into ${phoneAndTv.runtimeType} with weight ${phoneAndTv.totalWeight}');
}

// packer interface - callers will use packer through this interface
abstract interface class Packer {
  DeliveryItem pack(DeliveryItem item);

  DeliveryItem packMany(List<DeliveryItem> items);
}

// packer abstract class which has common logic, but doesn't know which exactly boxes to create
abstract class AbstractPacker implements Packer {
  @override
  DeliveryItem pack(DeliveryItem item) {
    return packMany([item]);
  }

  @override
  DeliveryItem packMany(List<DeliveryItem> items) {
    var packed = createContainer(items);
    // do additional work required for packing - register in DB, send to warehouse, etc.
    return packed;
  }

  DeliveryItem createContainer(List<DeliveryItem> items);
}

// packer which packs items into simple carton boxes
class SimplePacker extends AbstractPacker {
  @override
  DeliveryItem createContainer(List<DeliveryItem> items) {
    return CartonBox.withItems(items, 0.1);
  }
}

// packer which packs items into carton boxes with filler
class PackerWithFiller extends AbstractPacker {
  @override
  DeliveryItem createContainer(List<DeliveryItem> items) {
    return CartonBoxWithFiller.withItems(items, 0.1, 0.05);
  }
}

// packer which packs light items into simple carton boxes, and heavy items
// into carton boxes with filler
class CleverPacker extends AbstractPacker {
  @override
  DeliveryItem createContainer(List<DeliveryItem> items) {
    var totalWeight = items.fold(0.0, (sum, item) => sum + item.totalWeight);
    if (totalWeight < 1) {
      return CartonBox.withItems(items, 0.1);
    } else {
      return CartonBoxWithFiller.withItems(items, 0.1, 0.05);
    }
  }
}
