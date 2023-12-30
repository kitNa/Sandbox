import 'package:sandbox/src/exercises/017_operators_overrides/01_input_operator_override.dart';

void main() {

  Garage<Car> garage = Garage(length: 6.5, width: 3.5, height: 2.5);

  PlaneHangar planeHangar = PlaneHangar(length: 100, width: 100, height: 100);

  Car carBMW = Car(
      transportName: 'BMW', weight: 1.5, length: 4.9, width: 1.9, height: 1.5);

  Car carToyota = Car(
      transportName: 'Toyota',
      weight: 1.7,
      length: 4.5,
      width: 1.8,
      height: 1.6);

  CargoPlane plane = CargoPlane(
      transportName: 'Mriya',
      carryingCapacity: 174.0,
      weight: 285.0,
      length: 84.0,
      width: 88.0,
      height: 18.0);

  print(planeHangar);
  planeHangar << plane;
  print(planeHangar);
  planeHangar << plane;
  planeHangar >> plane;
  print(planeHangar);
  print('--------------------------');
  print(garage);
  garage << carBMW;
  print(garage);
  garage << carToyota;
  print(garage);
  garage >> carBMW;
  print(garage);
}

///PlaceToStoreTransport allows you to store objects of type [Transport].
abstract interface class PlaceToStoreTransport<T extends Transport> {
  void putTransport(T transport);

  void removeTransport(T transport);

  void operator <<(T transport);

  void operator >>(T transport);
}

abstract class AbstractPlaceToStoreTransport<T extends Transport>
    implements PlaceToStoreTransport<T> {

  ///Free space along the length.
  final double length;

  ///Free space along the width.
  final double width;

  ///Free space along the height.
  final double height;

  AbstractPlaceToStoreTransport(
      {required this.length, required this.width, required this.height});

  @override
  void operator >>(T transport) {
    removeTransport(transport);
  }

  @override
  void operator <<(T transport) {
    putTransport(transport);
  }
}

///Garage allows you to store only one  [Transport] type object at a time.
abstract class AbstractGarage<T extends Transport>
    extends AbstractPlaceToStoreTransport<T> {
  T? transport;

  AbstractGarage(
      {required super.length, required super.width, required super.height});

  ///Will keep the vehicle in the garage only if it fits in the dimensions
  ///If there is already a vehicle in the garage, this method will replace it with a new one.
  @override
  void putTransport(T transport) {
    bool lengthCheck = length > transport.length;
    bool widthCheck = width > transport.width;
    bool heightCheck = height > transport.height;

    if (lengthCheck && widthCheck && heightCheck) {
      this.transport = transport;
    } else {
      print('Sorry, there is not enough free space in the garage '
          'for this ${transport.transportName}');
    }
  }

  ///Removes [Transport] from the garage. If the specified vehicle is not in the garage, it prints a warning message.
  @override
  void removeTransport(T transport) {
    if (this.transport == transport) {
      this.transport = null;
    } else {
      print('Sorry, there is no ${transport.transportName} in the garage ');
    }
  }

  @override
  String toString() {
    if (transport != null) {
      return 'This garage contains ${transport?.transportName}';
    } else {
      return 'This garage is free';
    }
  }
}

///The hangar allows you to simultaneously store a list of [Transport] type objects.
abstract class AbstractHangar<T extends Transport>
    extends AbstractPlaceToStoreTransport<T> {
  List<T> hangar = <T>[];
  List g = [];
  double _hangarLength;
  double _hangarWidth;

  AbstractHangar(
      {required super.length, required super.width, required super.height})
      : _hangarLength = length,
        _hangarWidth = width;

  ///Adds [Transport] to the hangar only if there is enough free space. Otherwise, it prints a warning message.
  @override
  void putTransport(T transport) {
    bool lengthCheck = _hangarLength > transport.length;
    bool widthCheck = _hangarWidth > transport.width;
    bool heightCheck = super.height > transport.height;

    if (lengthCheck && widthCheck && heightCheck) {
      hangar.add(transport);
      _hangarLength -= (transport.length + 1);
      _hangarWidth -= (transport.width + 1);
    } else {
      print('Sorry, there is not enough free space in the hangar '
          'for this ${transport.transportName}');
    }
  }

  ///Removes [Transport] from the hangar. If the specified vehicle is not in the hangar, it prints a warning message.
  @override
  void removeTransport(T transport) {
    if (hangar.contains(transport)) {
      hangar.remove(transport);
      _hangarLength += (transport.length + 1);
      _hangarWidth += (transport.width + 1);
    } else {
      print('Sorry, there is no ${transport.transportName} in the hangar');
    }
  }

  @override
  String toString() {
    if (hangar.isNotEmpty) {
      return 'This hangar contains '
          '${hangar.map((transport) => transport.transportName)}';
    } else {
      return 'This hangar is free';
    }
  }
}

///Universal hangar for any [Transport]
class Hangar<T extends Transport> extends AbstractHangar<T> {
  Hangar({required super.length, required super.width, required super.height});
}

///Universal garage for any [Transport]
class Garage<T extends Transport> extends AbstractGarage<T> {
  Garage({required super.length, required super.width, required super.height});
}

class PlaneHangar extends AbstractHangar<CargoPlane> {
  PlaneHangar(
      {required super.length, required super.width, required super.height});
}

class ShipDock extends AbstractHangar<CargoShip> {
  ShipDock(
      {required super.length, required super.width, required super.height});
}
