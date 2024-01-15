//Программа для расчета полного веса посылок для отправки автомобилем.
// Вес посылки - это вес всех коробок/упаковок + вес самого товара.
// Есть два вида коробок - обычная и с наполнителем
// (разные способы расчета веса от размеров).
// Один товар может быть запакован в много слоев
// (коробка в коробке в коробке ...). И также несколько
// посылок могут комбинироваться в одну коробку (3 коробки в коробке).

// This is minimalistic example of composite pattern with most important parts.
// You can add more feature on top of minimal skeleton (dimensions, etc.).
// This is better approach to start with minimal skeleton and add features AFTER
// you have working code.

void main() {
  // resemble the example from site:
  // https://refactoring.guru/design-patterns/composite
  var hammer = Product(5);
  var phone = Product(0.2);
  var headphones = Product(0.05);
  var charger = Product(0.15);
  var receipt = Product(0.01);

  var hammerBox = CartonBox.withSingleItem(hammer, 0.15);
  var phoneAndHeadphonesBox = CartonBox.withItems([phone, headphones], 0.1);
  var chargerBox = CartonBox.withSingleItem(charger, 0.05);

  var phoneWithAccessoriesBox = CartonBox.withItems([phoneAndHeadphonesBox, chargerBox], 0.1);

  var rootBox = CartonBoxWithFiller.withItems([hammerBox, phoneWithAccessoriesBox, receipt], 0.5, 0.2);

  print("Total weight: ${rootBox.totalWeight}");
}

// Component
abstract interface class DeliveryItem {
  // skip dimensions for simplicity, they are not relevant for composite pattern

  /// Weight of the item itself
  double get weight;

  /// Total weight of the item with all included items
  double get totalWeight;
}

// Leaf
class Product implements DeliveryItem {
  @override
  final double weight;

  Product(this.weight);

  @override
  double get totalWeight => weight; // no sub-items, so total weight is the same as weight
}

// Composite base class
abstract class DeliveryContainer implements DeliveryItem {
  final List<DeliveryItem> _items = [];

  @override
  final double weight;

  DeliveryContainer(this.weight);

  DeliveryContainer.withSingleItem(DeliveryItem item, this.weight) {
    _items.add(item);
  }

  DeliveryContainer.withItems(List<DeliveryItem> items, this.weight) {
    _items.addAll(items);
  }

  void addItem(DeliveryItem item) {
    _items.add(item);
  }

  @override
  double get totalWeight {
    var total = weight;
    for (DeliveryItem subItem in _items) {
      total += subItem.totalWeight;
    }
    return total;
  }
}

// Composite impl 1
class CartonBox extends DeliveryContainer {
  CartonBox(double weight) : super(weight);

  CartonBox.withSingleItem(DeliveryItem item, double weight) : super.withSingleItem(item, weight);

  CartonBox.withItems(List<DeliveryItem> items, double weight) : super.withItems(items, weight);
}

// Composite impl 2
class CartonBoxWithFiller extends DeliveryContainer {
  final double fillerWeight;

  CartonBoxWithFiller(double weight, this.fillerWeight) : super(weight + fillerWeight);

  CartonBoxWithFiller.withSingleItem(DeliveryItem item, double weight, this.fillerWeight)
      : super.withSingleItem(item, weight + fillerWeight);

  CartonBoxWithFiller.withItems(List<DeliveryItem> items, double weight, this.fillerWeight)
      : super.withItems(items, weight + fillerWeight);

  double get cartonWeight => weight - fillerWeight;
}
