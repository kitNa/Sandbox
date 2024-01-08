import 'dart:math';
import 'dart:io';

void main() {
  sleep(const Duration(seconds: 3));
  Sensor sensor = Sensor();
  print(sensor.celsiusT);
  print(sensor.celsiusT);
  print(sensor.kelvinT);
}

class Sensor {
  int _sensorResistance = 0;
  DateTime _lastReadTime;

  Sensor()
      : _lastReadTime = DateTime.now() {
    _sensorResistance = _readResistanceFromSensor();
  }

  double get celsiusT {
    return getCelsiusT();
  }

  double get fahrenheitT {
    return getCelsiusT() * 1.8 + 32;
  }

  double get kelvinT {
    return getCelsiusT() + 273.15;
  }

  double getCelsiusT() {
    if (DateTime.now().difference(_lastReadTime).inMilliseconds > 500) {
      _sensorResistance = _readResistanceFromSensor();
    }
    return _sensorResistance * 0.18;
  }

  int _readResistanceFromSensor() {
    var newSensorResult = Random().nextInt(100);
    _lastReadTime = DateTime.now();
    print('reading new value from sensor: $newSensorResult');
    return newSensorResult;
  }
}
