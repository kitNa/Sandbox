import 'dart:html';

void main() {
  Boeing737 passengerPlane = Boeing737();
  print(passengerPlane.engine);
  passengerPlane.changeWings();

  BiplaneChristenEagle biplane = BiplaneChristenEagle();
  print(biplane.engine);
  biplane.changeWings();
}

//_____________________abstract interface______________________________________
abstract interface class Vehicle {
  String get steeringWheel;

  void turnRight();

  void turnLeft();

  bool isMoving(bool gas, bool brake);
}

abstract interface class VehiclesWithEngine implements Vehicle {
  String get engine;

  bool get isEngineWorking;

  void startTheEngine();

  void stopTheEngine();
}

abstract interface class VehiclesWithWheels implements Vehicle {
  int get wheels;

  void changeWheels();
}

abstract interface class VehiclesWithWings implements Vehicle {
  int get wings;

  void changeWings();
}

abstract interface class Car
    implements Vehicle, VehiclesWithEngine, VehiclesWithWheels {
  bool get brake;

  bool get gas;

  void pressGasPedal();

  void pressBrakePedal();
}

abstract interface class Plane
    implements Vehicle, VehiclesWithEngine, VehiclesWithWings {
  void releaseLandingGear();

  void hideLandingGear();

  void takeOff();

  void landing();
}

abstract interface class Bicycle implements Vehicle {
  void spinThePedals();
}

//____________________abstract class___________________________________________
abstract class SteerableVehicle implements Vehicle {
  @override
  void turnLeft() {
    print('You turned left');
  }

  @override
  void turnRight() {
    print('You turned right');
  }
}

abstract class MotorVehicle extends SteerableVehicle implements VehiclesWithEngine {

  @override
  bool isEngineWorking = false;

  @override
  void startTheEngine() {
    isEngineWorking = true;
  }

  @override
  void stopTheEngine() {
    isEngineWorking = false;
  }

  @override
  bool isMoving(bool gas, bool brake) {
    if (gas == true && brake == false) {
      print('The car is moving');
      return true;
    } else if (gas == false && brake == true) {
      print('The car is not moving');
      return false;
    } else {
      throw Exception('Stop breaking the car! Release one of the pedals');
    }
  }
}

abstract class TypicalPlane extends MotorVehicle
    implements Plane {
  static const int numberOfWings = 2;

  @override
  int get wings => numberOfWings;

  @override
  String get steeringWheel => 'Airplane steering wheel';

  @override
  void releaseLandingGear() {
    print('The landing gear was released');
  }

  @override
  void hideLandingGear() {
    print('The landing gear was hidden');
  }

  @override
  void changeWings() {
    print('$numberOfWings were replaced');
  }

  @override
  void takeOff() {
    print('Takeoff is completed');
  }

  @override
  void landing() {
    print('Landing is made');
  }
}

abstract class TypicalBiplane extends TypicalPlane {
  static const int numberOfWings = 4;

  @override
  int get wings => numberOfWings;

  @override
  void changeWings() {
    print('$numberOfWings were replaced');
  }
}

abstract class TypicalCar extends MotorVehicle implements Car {
  static const int numberOfWheels = 4;

  @override
  bool brake = true;

  @override
  bool gas = false;

  @override
  int get wheels => numberOfWheels;

  @override
  String get steeringWheel => 'Car steering wheel';

  @override
  void changeWheels() {
    print('4 wheels were replaced');
  }

  @override
  void pressGasPedal() {
    if (isEngineWorking = true) {
      gas = true;
      brake = false;
    } else {
      throw Exception('Engine off! Start the car');
    }
  }

  @override
  void pressBrakePedal() {
    gas = false;
    brake = true;
  }
}

abstract class TypicalBicycle extends SteerableVehicle implements Bicycle {
  @override
  void spinThePedals() {
    print('The pedals are spinning');
  }
}

//____________________concrete class__________________________________________
class CarBMW extends TypicalCar {
  @override
  String get engine => 'Internal combustion engine';
}

class CarVolkswagen extends TypicalCar {
  @override
  String get engine => 'Electric motor';
}
class Boeing737 extends TypicalPlane {
  @override
  String get engine => 'JT8D (-100, -200), CFMI CFM56-3 (-300, -400, -500)';
}

class  BiplaneChristenEagle extends TypicalBiplane {
  @override
  String get engine => 'Valach VM210 B2 opposed twin';
}
