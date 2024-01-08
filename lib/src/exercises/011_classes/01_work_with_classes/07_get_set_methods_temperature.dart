void main() {
  Temperature temperature = Temperature(45);
  print('temperature in Celsius: ${temperature.celsius}'); //45.0
  print('temperature in Kelvin: ${temperature.kelvin}'); //318.15
  print('temperature in Fahrenheit: ${temperature.fahrenheit}'); //113.0
}

class Temperature {
  double celsius;

  Temperature(this.celsius);

  double get fahrenheit {
    return celsius * 1.8 + 32;
  }
  set fahrenheit (double temperatureFahrenheit) {
    celsius = (temperatureFahrenheit - 32) / 1.8;
  }

  double get kelvin {
    return celsius + 273.15;
  }
  set kelvin (double temperatureKelvin) {
    celsius = temperatureKelvin - 273.15;
  }
}
