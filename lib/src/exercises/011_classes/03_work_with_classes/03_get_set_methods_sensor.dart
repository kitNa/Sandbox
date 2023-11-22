import 'dart:math';

void main() {
  Sensor sensor = Sensor();
  print(sensor.celsiusT);
  print(sensor.celsiusT);
  print(sensor.kelvinT);
}

class Sensor {
  int _sensorResistance = 15;
  DateTime _lastReadTime;

  Sensor()
      : _lastReadTime = DateTime.now();

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
    _lastReadTime = DateTime.now();
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
