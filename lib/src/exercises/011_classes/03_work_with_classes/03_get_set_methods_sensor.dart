import 'dart:math';

void main() {}

class Sensor {
  int _sensorResistance;
  DateTime _lastReadTime;

  Sensor()
      : _sensorResistance = _readResistanceFromSensor(),
        _lastReadTime = DateTime.now();

  double get celsiusT {
    return getCelsiusT();
  }

  double get fahrenheitT {
    return getCelsiusT() * 1.8 + 32;
  }

  double get kelvinT {
    return getCelsiusT() + 273.15;
  }

  int _readResistanceFromSensor() {
    var newSensorResult = Random().nextInt(100);
    print('reading new value from sensor: $newSensorResult');
    return newSensorResult;
  }

  double getCelsiusT() {
    if (DateTime.now().difference(_lastReadTime).inMicroseconds > 100) {
      _sensorResistance = _readResistanceFromSensor();
    }
    return _sensorResistance * 0.18;
  }
}
