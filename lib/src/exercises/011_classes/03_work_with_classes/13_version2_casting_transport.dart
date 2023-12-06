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

  //The argument type 'Car' can't be assigned to the parameter type 'CargoTransport'.
  //transportOfVehicles(car, abstractCar, 25);
  print('___________________________________');
  Truck truck = Truck(
      transportName: 'Volvo',
      bodyVolume: 85.0,
      carryingCapacity: 17.0,
      weight: 20.0);
  transportOfVehicles(truck, car, 2);
}

void transportOfVehicles(
    //A mixin can specify a type
    CargoTransport transport,
    Transport vehicles,
    int num) {
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

mixin CargoTransport implements Transport {
  double get carryingCapacity;
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

class Truck extends AbstractLandTransportWithWheels with CargoTransport {
  final double _bodyVolume;
  final String _transportName;
  final double _weight;
  final double _carryingCapacity;

  Truck(
      {required transportName,
      required bodyVolume,
      required carryingCapacity,
      required weight})
      : _transportName = transportName,
        _weight = weight,
        _carryingCapacity = carryingCapacity,
        _bodyVolume = bodyVolume;

  @override
  String get transportName => _transportName;

  @override
  double get weight => _weight;

  @override
  double get carryingCapacity => _carryingCapacity;

  double get bodyVolume => _bodyVolume;
}

class PassengerTrain extends AbstractLandTransportOnRails {
  int numberOfSeats;
  final String _transportName;
  final double _weight;

  PassengerTrain(
      {required transportName, required this.numberOfSeats, required weight})
      : _transportName = transportName,
        _weight = weight;

  @override
  String get transportName => _transportName;

  @override
  double get weight => _weight;
}

class CargoTrain extends AbstractLandTransportOnRails with CargoTransport {
  final String _transportName;
  final double _weight;
  final double _carryingCapacity;

  CargoTrain(
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

class PassengerPlane extends AbstractAirTransportWithWings {
  int numberOfSeats;
  final String _transportName;
  final double _weight;

  PassengerPlane(
      {required transportName, required this.numberOfSeats, required weight})
      : _transportName = transportName,
        _weight = weight;

  @override
  String get transportName => _transportName;

  @override
  double get weight => _weight;
}

class CargoPlane extends AbstractAirTransportWithWings with CargoTransport {
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

  Helicopter({required transportName, required weight})
      : _transportName = transportName,
        _weight = weight;

  @override
  String get transportName => _transportName;

  @override
  double get weight => _weight;
}

class PassengerShip extends AbstractWaterTransport {
  int numberOfSeats;
  final double _weight;
  final String _transportName;

  PassengerShip(
      {required transportName, required this.numberOfSeats, required weight})
      : _transportName = transportName,
        _weight = weight;

  @override
  String get transportName => _transportName;

  @override
  double get weight => _weight;
}

class CargoShip extends AbstractWaterTransport with CargoTransport {
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
