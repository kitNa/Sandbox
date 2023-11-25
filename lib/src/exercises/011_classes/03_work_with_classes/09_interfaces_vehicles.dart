import 'dart:html';

void main() {}

//_____________________abstract interface______________________________________
abstract interface class Vehicles {
  String get steeringWheel;

  // void turnRight();
  //
  // void turnLeft();

  void turnLeft(){
    print('You turned left');
  }

  void turnRight(){
    print('You turned right');
  }

  bool isMoving(bool gas, bool brake);
}

abstract interface class vehiclesWithEngine implements Vehicles {
  String get engine;

  bool get isEngineWorking;

  void startTheEngine();

  void stopTheEngine();
}

abstract interface class vehiclesWithWheels implements Vehicles {
  int get wheels;

  void changeWheels();
}

abstract interface class vehiclesWithWings implements Vehicles {
  int get wings;

  void changeWings();
}

//____________________abstract class___________________________________________
abstract class Plane
    implements
        Vehicles,
        vehiclesWithEngine,
        vehiclesWithWings,
        vehiclesWithWheels {
  void releaseLandingGear();

  void hideLandingGear();

  void takeOff();

  void landing();
}

abstract class Car implements Vehicles, vehiclesWithEngine, vehiclesWithWheels {
  bool get gas;

  bool get brake;

  void pressedGasPedal();

  void pressedBrakePedal();
}

abstract class Ship implements Vehicles, vehiclesWithEngine {
  void pressedGasButton();

  void pressedBrakeButton();
}

abstract class Bicycle implements Vehicles {
  void spinThePedals();
}

//____________________concrete class__________________________________________
class BMW extends Vehicles implements Car {
  @override
  bool brake = true;

  @override
  bool gas = false;

  @override
  int get wheels => 4;

  @override
  bool isEngineWorking = false;

  @override
  String get steeringWheel => 'Car steering wheel';

  @override
  void changeWheels() {
    print('4 wheels were replaced');
  }

  @override
  String get engine => 'Internal combustion engine';

  @override
  void pressedGasPedal() {
    if (isEngineWorking = true) {
      gas = true;
      brake = false;
    }
    else {
      throw Exception('Engine off! Start the car');
    }
  }

  @override
  void pressedBrakePedal() {
    gas = false;
    brake = true;
  }

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
    }  else if (gas == false && brake == true) {
      print('The car is not moving');
      return false;
    } else {
      throw Exception('Stop breaking the car! Release one of the pedals');
    }
  }
}
