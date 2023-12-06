void main() {

}

//_____________________abstract interface______________________________________
abstract interface class Transport {
  String get engineType;

  void move();

  void stop();

  void accelerate();

  void slowDown();

  void refuel();
}

abstract interface class LandTransport implements Transport {
}

abstract interface class AirTransport implements Transport {
  void takeOff();

  void landing();
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

abstract class AbstractWaterTransport with HandleControl implements WaterTransport {
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
  final String _engineType;

  Car(this._engineType);

  @override
  String get engineType => _engineType;
}

class Bus extends AbstractLandTransportWithWheels {
  int numberOfSeats;
  final String _engineType;

  Bus(this._engineType, this.numberOfSeats);

  @override
  String get engineType => _engineType;
}

class Truck extends AbstractLandTransportWithWheels {
  int bodyVolume;
  final String _engineType;

  Truck(this._engineType, this.bodyVolume);

  @override
  String get engineType => _engineType;
}

class PassengerPlane extends AbstractAirTransportWithWings {
  int numberOfSeats;
  final String _engineType;

  PassengerPlane(this._engineType, this.numberOfSeats);

  @override
  String get engineType => _engineType;
}

class CargoPlane extends AbstractWaterTransport {
  int carryingCapacity;
  final String _engineType;

  CargoPlane(this._engineType, this.carryingCapacity);

  @override
  String get engineType => _engineType;
}

class Helicopter extends AbstractAirTransportWithPropeller {
  int carryingCapacity;
  final String _engineType;

  Helicopter(this._engineType, this.carryingCapacity);

  @override
  String get engineType => _engineType;
}

class PassengerShip extends AbstractWaterTransport {
  int numberOfSeats;
  final String _engineType;

  PassengerShip(this._engineType, this.numberOfSeats);

  @override
  String get engineType => _engineType;
}


class CargoShip extends AbstractWaterTransport {
  int carryingCapacity;
  final String _engineType;

  CargoShip(this._engineType, this.carryingCapacity);

  @override
  String get engineType => _engineType;
}
