import 'dart:ffi';

void main() {
  Car car = Car('BMW', 1.7);
  print(car.transportName);
  car.spareWheel();

  print('___________________________________');
  //upcast
  AbstractLandTransportWithWheels abstractCar = car;
  print('AbstractLandTransportWithWheels name is ${abstractCar.transportName}');
  //The method 'spareWheel' isn't defined for the type 'AbstractLandTransportWithWheels'.
  //abstractCar.spareWheel();

  //downcast
  //A value of type 'AbstractLandTransportWithWheels' can't be assigned to a variable of type 'Car'.
  //Car newCar = abstractCar;

  CargoPlane plane = CargoPlane(
      transportName: 'Mriya', carryingCapacity: 174.0, weight: 285.0);

  print('___________________________________');
  transportOfVehicles(plane, car, 25);

  print('___________________________________');
  transportOfVehicles(plane, car, 1000);

  print('___________________________________');
  transportOfVehicles(plane, abstractCar, 25);
}

void transportOfVehicles(
    CargoTransport transport, Transport vehicles, int num) {
  if (vehicles.weight * num < transport.carryingCapacity) {
    print('This cargo can be transported in the specified way');
  } else {
    print('Look for another way of transporting the cargo');
  }
}

//_____________________abstract interface______________________________________
abstract interface class Transport {
  String get transportName;

  double get weight;

  void move();

  void stop();

  void accelerate();

  void slowDown();

  void refuel();
}

abstract interface class CargoTransport implements Transport {
  double get carryingCapacity;
}

abstract interface class LandTransport implements Transport {}

abstract interface class AirTransport implements CargoTransport {
  void landing();

  void takeOff();
}

abstract interface class WaterTransport implements CargoTransport {
  void dropAnchor();

  void raiseAnchor();
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


//____________________abstract class___________________________________________
abstract class AbstractLandTransportWithWheels implements LandTransport {
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

abstract class AbstractLandTransportOnRails
    with HandleControl
    implements LandTransport {
  @override
  void refuel() {
    print('In the depot the tank was filled to the brim');
  }
}

abstract class AbstractAirTransport with HandleControl implements AirTransport {
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
  @override
  void refuel() {
    print('At the airport tank was filled to the brim');
  }
}

abstract class AbstractAirTransportWithPropeller extends AbstractAirTransport {
  @override
  void refuel() {
    print('At the helipad tank was filled to the brim');
  }
}

abstract class AbstractWaterTransport
    with HandleControl
    implements WaterTransport {
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
  final String _transportName;
  final double _weight;

  Car(this._transportName, this._weight);

  @override
  String get transportName => _transportName;

  @override
  double get weight => _weight;

  void spareWheel() {
    print('The spare wheel is secured');
  }
}

class Bus extends AbstractLandTransportWithWheels {
  int numberOfSeats;
  final String _transportName;
  final double _weight;

  Bus({required transportName, required this.numberOfSeats, required weight})
      : _transportName = transportName,
        _weight = weight;

  @override
  String get transportName => _transportName;

  @override
  double get weight => _weight;
}

class Truck extends AbstractLandTransportWithWheels {
  int bodyVolume;
  final String _transportName;
  final double _weight;

  Truck({required transportName, required this.bodyVolume, required weight})
      : _transportName = transportName,
        _weight = weight;

  @override
  String get transportName => _transportName;

  @override
  double get weight => _weight;
}

class Train extends AbstractLandTransportOnRails {
  int numberOfSeats;
  final String _transportName;
  final double _weight;

  Train({required transportName, required this.numberOfSeats, required weight})
      : _transportName = transportName,
        _weight = weight;

  @override
  String get transportName => _transportName;

  @override
  double get weight => _weight;
}

class PassengerPlane extends AbstractAirTransportWithWings {
  int numberOfSeats;
  final String _transportName;
  final double _weight;
  final double _carryingCapacity;

  PassengerPlane(
      {required transportName,
      required this.numberOfSeats,
      required carryingCapacity,
      required weight})
      : _transportName = transportName,
        _weight = weight,
        _carryingCapacity = carryingCapacity;

  @override
  String get transportName => _transportName;

  @override
  double get weight => _weight;

  @override
  double get carryingCapacity => _carryingCapacity;
}

class CargoPlane extends AbstractWaterTransport {
  final String _transportName;
  final double _weight;
  final double _carryingCapacity;

  CargoPlane(
      {required transportName, required carryingCapacity, required weight})
      : _transportName = transportName,
        _weight = weight,
        _carryingCapacity = carryingCapacity;

  @override
  String get transportName => _transportName;

  @override
  double get weight => _weight;

  @override
  double get carryingCapacity => _carryingCapacity;
}

class Helicopter extends AbstractAirTransportWithPropeller {
  final String _transportName;
  final double _weight;
  final double _carryingCapacity;

  Helicopter(
      {required transportName, required carryingCapacity, required weight})
      : _transportName = transportName,
        _weight = weight,
        _carryingCapacity = carryingCapacity;

  @override
  String get transportName => _transportName;

  @override
  double get weight => _weight;

  @override
  double get carryingCapacity => _carryingCapacity;
}

class PassengerShip extends AbstractWaterTransport {
  int numberOfSeats;
  final double _weight;
  final String _transportName;
  final double _carryingCapacity;

  PassengerShip(
      {required transportName,
      required this.numberOfSeats,
      required carryingCapacity,
      required weight})
      : _transportName = transportName,
        _weight = weight,
        _carryingCapacity = carryingCapacity;

  @override
  String get transportName => _transportName;

  @override
  double get weight => _weight;

  @override
  double get carryingCapacity => _carryingCapacity;
}

class CargoShip extends AbstractWaterTransport {
  final double _weight;
  final String _transportName;
  final double _carryingCapacity;

  CargoShip(
      {required transportName, required carryingCapacity, required weight})
      : _transportName = transportName,
        _weight = weight,
        _carryingCapacity = carryingCapacity;

  @override
  String get transportName => _transportName;

  @override
  double get weight => _weight;

  @override
  double get carryingCapacity => _carryingCapacity;
}
