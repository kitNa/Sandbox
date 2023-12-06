void main() {
  PhoneWithHiddenNumber phone1 = PhoneWithHiddenNumber();
  phone1.call('+380662703723', 'Katya');
  print(phone1.number);
  print('______________');
  PhoneWithVoiceChanger phone2 = PhoneWithVoiceChanger();
  phone2.call('+380662703723', 'Katya');
  print(phone2.number);
}

abstract class AbstractPhone {
  String number = '+380662341534';

  void call(String number, String whatToSay) {
    print(number);
    print(whatToSay);
  }
}

class PhoneWithHiddenNumber extends AbstractPhone {
  @override
  get number => super.number.replaceRange(11, 13, '***');
}

class PhoneWithVoiceChanger extends AbstractPhone {
  @override
  void call(String number, String whatToSay) {
    super.call(number, 'Hallo, ' + whatToSay);
  }
}
