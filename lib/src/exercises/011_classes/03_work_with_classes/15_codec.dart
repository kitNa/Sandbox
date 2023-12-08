import 'dart:ffi';

void main() {
  Garage<AbstractLandTransportWithWheels> garage =
      Garage(garageLength: 6.5, garageWidth: 3.5, garageHeight: 2.5);
  print(garage);
  Hangar<Transport> hangar =
      Hangar(hangarLength: 100, hangarWidth: 100, hangarHeight: 30);
  print(hangar);

  Car carBMW = Car(
      transportName: 'BMW', weight: 1.5, length: 4.9, width: 1.9, height: 1.5);

  Car carToyota = Car(
      transportName: 'Toyota',
      weight: 1.7,
      length: 4.5,
      width: 1.8,
      height: 1.6);

  Truck truck = Truck(
      transportName: 'Truck',
      bodyVolume: 20.0,
      weight: 20.0,
      carryingCapacity: 17.0,
      length: 13.6,
      width: 2.45,
      height: 2.5);

  CargoPlane plane = CargoPlane(
      transportName: 'Mriya',
      carryingCapacity: 174.0,
      weight: 285.0,
      length: 84.0,
      width: 88.0,
      height: 18.0);

  print('___________________________________');
  garage.putTransport(carBMW);
  print(garage);
  print('___________________________________');
  garage.putTransport(carToyota);
  print(garage);
  print('___________________________________');
  garage.putTransport(truck);
  print(garage);
  print('___________________________________');
  garage.removeTransport(carBMW);
  garage.removeTransport(carToyota);
  print(garage);
  print('___________________________________');
  hangar.putTransport(truck);
  print(hangar);
  print('___________________________________');
  hangar.putTransport(carToyota);
  print(hangar);
  print('___________________________________');
  hangar.removeTransport(carToyota);
  print(hangar);
  print('___________________________________');
  hangar.removeTransport(truck);
  print(hangar);
  print('___________________________________');
  hangar.putTransport(plane);
  print(hangar);
  print('___________________________________');
}

abstract interface class PlaceToStoreTransport<T extends Transport> {
  void putTransport(T transport);
  void removeTransport(T transport);
}

abstract class AbstractGarage<T extends Transport>
    implements PlaceToStoreTransport<T> {
  T? transport;
  final double garageLength;
  final double garageWidth;
  final double garageHeight;

  AbstractGarage(
      {required this.garageLength,
      required this.garageWidth,
      required this.garageHeight});

  @override
  void putTransport(T transport) {
    bool lengthCheck = garageLength > transport.length;
    bool widthCheck = garageWidth > transport.width;
    bool heightCheck = garageHeight > transport.height;

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
    implements PlaceToStoreTransport<T> {
  List<T> hangar = <T>[];
  List g = [];
  double hangarLength;
  double hangarWidth;
  double hangarHeight;

  AbstractHangar(
      {required this.hangarLength,
      required this.hangarWidth,
      required this.hangarHeight});

  @override
  void putTransport(T transport) {
    bool lengthCheck = hangarLength > transport.length;
    bool widthCheck = hangarWidth > transport.width;
    bool heightCheck = hangarHeight > transport.height;

    if (lengthCheck && widthCheck && heightCheck) {
      hangar.add(transport);
      hangarLength -= (transport.length + 1);
      hangarWidth -= (transport.width + 1);
    } else {
      print('Sorry, there is not enough free space in the hangar '
          'for this ${transport.transportName}');
    }
  }

  @override
  void removeTransport(T transport) {
    if (hangar.contains(transport)) {
      hangar.remove(transport);
      hangarLength += (transport.length + 1);
      hangarWidth += (transport.width + 1);
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
  Hangar(
      {required super.hangarLength,
      required super.hangarWidth,
      required super.hangarHeight});
}

class Garage<T extends Transport> extends AbstractGarage<T> {
  Garage(
      {required super.garageLength,
      required super.garageWidth,
      required super.garageHeight});
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
