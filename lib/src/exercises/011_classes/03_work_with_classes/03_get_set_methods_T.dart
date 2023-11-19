void main() {
  Temperature temperature = Temperature(45);
  print('temperature in Celsius: ${temperature.celsius}'); //45.0
  print('temperature in Kelvin: ${temperature.kelvin}'); //318.15
  print('temperature in Fahrenheit: ${temperature.fahrenheit}'); //113.0
  temperature.fahrenheit = 113;
  print('temperature in Celsius: ${temperature.celsius}'); //45.0
  print('temperature in Kelvin: ${temperature.kelvin}'); //318.15
  print('temperature in Fahrenheit: ${temperature.fahrenheit}'); //113.0
}

class Temperature {
  double _temperatureCelsius;

  Temperature(this._temperatureCelsius);

  double get celsius => _temperatureCelsius;
  set celsius(double temperatureCelsius) => _temperatureCelsius = temperatureCelsius;

  double get fahrenheit {
    return _temperatureCelsius * 1.8 + 32;
  }
  set fahrenheit (double temperatureFahrenheit) {
    _temperatureCelsius = (temperatureFahrenheit - 32) / 1.8;
  }

  double get kelvin {
    return _temperatureCelsius + 273.15;
  }
  set kelvin (double temperatureKelvin) {
    _temperatureCelsius = temperatureKelvin - 273.15;
  }
}
