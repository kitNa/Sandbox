// сделай ИНТЕРФЕЙС Codec<In, Out> (или можешь его ограничить
// AnimalCodec<In extends String, Out extends Animal>), и
// создай парочку реализаций с конкретизированными типами, напрмер
// — class AlligatorCodec<String, Alligator>
// — class HoneyBadgerCodec<String, HoneyBadger>

import 'dart:html';

import 'package:sandbox/src/exercises/001_basics_variables/variables.dart';
import 'package:sandbox/src/exercises/011_classes/03_work_with_classes/14_generics.dart';

void main() {}

abstract interface class Codec<In extends String, Out extends Transport> {
  Out getCar(In string);
}

abstract class AbstractTransportWithWheelsCodec<In extends String,
    Out extends AbstractLandTransportWithWheels> implements Codec<In, Out> {
  AbstractLandTransportWithWheels getCar(In string) {
    List words = string.split(' -');
    print(words);

    for (int i = 0; i < words.length; i++) {
      String? transportName;
      double? weight;
      double? length;
      double? width;
      double? height;
      int? numberOfSeats;
      double? bodyVolume;
      double? carryingCapacity;

      if (words[i] == 'is') {
        transportName = words[i + 1];
      }
      if (words[i] == 'weight') {
        weight = double.tryParse(words[i + 1]);
      }
      if (words[i] == 'length') {
        length = double.tryParse(words[i + 1]);
      }
      if (words[i] == 'width') {
        width = double.tryParse(words[i + 1]);
      }
      if (words[i] == 'height') {
        height = double.tryParse(words[i + 1]);
      }
      if (words[i] == 'seats') {
        numberOfSeats = int.tryParse(words[i + 1]);
      }
      if (words[i] == 'volume') {
        bodyVolume = double.tryParse(words[i + 1]);
      }
      if (words[i] == 'capacity') {
        carryingCapacity = double.tryParse(words[i + 1]);
      }

      bool transportIsTruck = words.contains('capacity');
      bool transportIsBus = words.contains('seats');
      if (transportIsTruck) {
        return Truck(
            transportName: transportName,
            bodyVolume: bodyVolume,
            carryingCapacity: carryingCapacity,
            weight: weight);
      } else if (transportIsBus) {
        return Bus(
            transportName: transportName,
            numberOfSeats: numberOfSeats,
            weight: weight);
      } else {
        return Car(
            transportName: transportName,
            weight: weight,
            length: length,
            width: width,
            height: height);
      }
    }
  }
}
