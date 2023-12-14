void main() {
  Garage<Car> garage =
  Garage(length: 6.5, width: 3.5, height: 2.5);

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

abstract interface class PlaceToStoreTransport<T extends Transport> {
  void putTransport(T transport);

  void removeTransport(T transport);

  void operator <<(T transport);

  void operator >>(T transport);
}

abstract class AbstractPlaceToStoreTransport<T extends Transport>
    implements PlaceToStoreTransport<T> {
  final double length;
  final double width;
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

abstract class AbstractGarage<T extends Transport>
    extends AbstractPlaceToStoreTransport<T> {
  T? transport;

  AbstractGarage(
      {required super.length, required super.width, required super.height});

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

class Hangar<T extends Transport> extends AbstractHangar<T> {
  Hangar({required super.length, required super.width, required super.height});
}

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

void transportOfVehicles(
    CargoTransport transport, Transport vehicles, int num) {
  if (vehicles.weight * num < transport.carryingCapacity) {
    print(
        '$num ${vehicles.transportName} can be transported in the ${transport.transportName}');
  } else {
    print('Look for another way of transporting the cargo');
  }
}

//_____________________abstract interface______________________________________
abstract interface class Transport {
  String get transportName;

  double get weight;

  double get length;

  double get width;

  double get height;

  void move();

  void stop();

  void accelerate();

  void slowDown();

  void refuel();
}

abstract interface class LandTransport implements Transport {}

abstract interface class AirTransport implements Transport {
  void landing();

  void takeOff();
}

abstract interface class WaterTransport implements Transport {
  void dropAnchor();

  void raiseAnchor();
}

abstract interface class CargoTransport implements Transport {
  double get carryingCapacity;
}

//_____________________Mixins_______________________________________________
mixin HandleControl {
  void move() {
    print('The transport is started and the motion handle is raised');
  }

  void stop() {
    print('The motion handle is lowered to the train is muted');
  }

  void accelerate() {
    print(
        'The motion handle is raised higher, the speed is increased by 20 km per hour');
  }

  void slowDown() {
    print(
        'The drive handle is lowered, the speed is reduced by 20 km per hour');
  }
}

mixin MixinCargoTransport implements CargoTransport {
  @override
  double get carryingCapacity;
}

//____________________abstract class___________________________________________
abstract class AbstractTransport implements Transport {
  @override
  final String transportName;

  @override
  final double weight;

  @override
  final double length;

  @override
  final double width;

  @override
  final double height;

  AbstractTransport(
      {required this.transportName,
      required this.weight,
      required this.length,
      required this.width,
      required this.height});
}

abstract class AbstractLandTransportWithWheels extends AbstractTransport
    implements LandTransport {
  AbstractLandTransportWithWheels(
      {required super.transportName,
      required super.weight,
      required super.length,
      required super.width,
      required super.height});

  @override
  void move() {
    print('The transport is started and the gas pedal is pressed');
  }

  @override
  void stop() {
    print('The brake pedal is pressed and the car is stopped');
  }

  @override
  void accelerate() {
    print(
        'The gas pedal is pressed harder, the speed is increased by 10 km per hour');
  }

  @override
  void slowDown() {
    print(
        'The gas pedal is pressed more slowly, the speed is reduced by 10 km per hour');
  }

  @override
  void refuel() {
    print('At the gas station the tank was filled to the brim');
  }
}

abstract class AbstractLandTransportOnRails extends AbstractTransport
    with HandleControl
    implements LandTransport {
  AbstractLandTransportOnRails(
      {required super.transportName,
      required super.weight,
      required super.length,
      required super.width,
      required super.height});

  @override
  void refuel() {
    print('In the depot the tank was filled to the brim');
  }
}

abstract class AbstractAirTransport extends AbstractTransport
    with HandleControl
    implements AirTransport {
  AbstractAirTransport(
      {required super.transportName,
      required super.weight,
      required super.length,
      required super.width,
      required super.height});

  @override
  void takeOff() {
    print('The transport is prepared, it leaves the ground');
  }

  @override
  void landing() {
    print('The landing site is prepared, the transport is landing');
  }
}

abstract class AbstractAirTransportWithWings extends AbstractAirTransport {
  AbstractAirTransportWithWings(
      {required super.transportName,
      required super.weight,
      required super.length,
      required super.width,
      required super.height});

  @override
  void refuel() {
    print('At the airport tank was filled to the brim');
  }
}

abstract class AbstractAirTransportWithPropeller extends AbstractAirTransport {
  AbstractAirTransportWithPropeller(
      {required super.transportName,
      required super.weight,
      required super.length,
      required super.width,
      required super.height});

  @override
  void refuel() {
    print('At the helipad tank was filled to the brim');
  }
}

abstract class AbstractWaterTransport extends AbstractTransport
    with HandleControl
    implements WaterTransport {
  AbstractWaterTransport(
      {required super.transportName,
      required super.weight,
      required super.length,
      required super.width,
      required super.height});

  @override
  void dropAnchor() {
    print('The anchor is lowered');
  }

  @override
  void raiseAnchor() {
    print('The anchor is raised');
  }

  @override
  void refuel() {
    print('At the seaport tank was filled to the brim');
  }
}

//____________________concrete class___________________________________________
class Car extends AbstractLandTransportWithWheels {
  Car(
      {required super.transportName,
      required super.weight,
      required super.length,
      required super.width,
      required super.height});
}

class Bus extends AbstractLandTransportWithWheels {
  final int numberOfSeats;

  Bus(
      {required super.transportName,
      required this.numberOfSeats,
      required super.weight,
      required super.length,
      required super.width,
      required super.height});
}

class Truck extends AbstractLandTransportWithWheels
    with MixinCargoTransport
    implements CargoTransport {
  final double bodyVolume;

  @override
  double carryingCapacity;

  Truck(
      {required super.transportName,
      required this.bodyVolume,
      required this.carryingCapacity,
      required super.weight,
      required super.length,
      required super.width,
      required super.height});
}

class PassengerTrain extends AbstractLandTransportOnRails {
  int numberOfSeats;

  PassengerTrain(
      {required super.transportName,
      required this.numberOfSeats,
      required super.weight,
      required super.length,
      required super.width,
      required super.height});
}

class CargoTrain extends AbstractLandTransportOnRails with MixinCargoTransport {
  @override
  double carryingCapacity;

  CargoTrain(
      {required super.transportName,
      required this.carryingCapacity,
      required super.weight,
      required super.length,
      required super.width,
      required super.height});
}

class PassengerPlane extends AbstractAirTransportWithWings {
  int numberOfSeats;

  PassengerPlane(
      {required super.transportName,
      required this.numberOfSeats,
      required super.weight,
      required super.length,
      required super.width,
      required super.height});
}

class CargoPlane extends AbstractAirTransportWithWings
    with MixinCargoTransport {
  @override
  double carryingCapacity;

  CargoPlane(
      {required super.transportName,
      required this.carryingCapacity,
      required super.weight,
      required super.length,
      required super.width,
      required super.height});
}

class Helicopter extends AbstractAirTransportWithPropeller {
  Helicopter(
      {required super.transportName,
      required super.weight,
      required super.length,
      required super.width,
      required super.height});
}

class PassengerShip extends AbstractWaterTransport {
  int numberOfSeats;

  PassengerShip(
      {required super.transportName,
      required this.numberOfSeats,
      required super.weight,
      required super.length,
      required super.width,
      required super.height});
}

class CargoShip extends AbstractWaterTransport with MixinCargoTransport {
  @override
  double carryingCapacity;

  CargoShip(
      {required super.transportName,
      required this.carryingCapacity,
      required super.weight,
      required super.length,
      required super.width,
      required super.height});
}
