import '../../014_generics/01_generics.dart';

void main() {
  // transportName: transportName,
  // weight: weight,
  // length: length,
  // width: width,
  // height: height);
  // TransportWithWheelsCodec codec= TransportWithWheelsCodec('This is BMW car with'
  //     ' weight 1.5 tons,length 4.9 meter, width 1.9 meter and height 1.5 meter');

  //Car car = codec.getTransport();
}

abstract interface class Codec<I extends String, O extends Transport> {
  O? getTransport();
}

abstract class AbstractTransportWithWheelsCodec<In extends String,
Out extends AbstractLandTransportWithWheels>
    implements Codec<In, Out> {

  In transportDescription;

  AbstractTransportWithWheelsCodec(this.transportDescription);

  Out? getTransport() {
    List words = transportDescription.split(RegExp(" -,"));
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

      //WARNING!!!
      // 1. Abstract class should not know about sub classes
      // 2. Branches with concrete types should be replaced with polymorphism

      // if (transportIsTruck) {
      //   return Truck(
      //       transportName: transportName,
      //       bodyVolume: bodyVolume,
      //       carryingCapacity: carryingCapacity,
      //       weight: weight,
      //       length: length,
      //       width: width,
      //       height: height);
      // } else if (transportIsBus) {
      //   return Bus(
      //       transportName: transportName,
      //       numberOfSeats: numberOfSeats,
      //       weight: weight);
      // } else {
      //   return Car(
      //       transportName: transportName,
      //       weight: weight,
      //       length: length,
      //       width: width,
      //       height: height);
      // }
    }
  }
}
