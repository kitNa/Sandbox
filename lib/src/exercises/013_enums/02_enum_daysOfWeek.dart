void main() {
  DaysOfWeek.values.forEach((element) => print('${element.name} - $element'));

  print('______________________________');
  String dayOfWeek  = 'monday';
  DaysOfWeek.values.forEach((element) {
    if(element.name == dayOfWeek) {
      print("${element.name} is working day: ${element.isWorkingDay}");
    }
  });
}

enum DaysOfWeek {
  sunday(1),
  monday(2),
  tuesday(3),
  wednesday(4),
  thursday(5),
  friday(6),
  saturday(7);

  final int _number;
  const DaysOfWeek(this._number);

  bool get isWorkingDay {
    if (_number  == 1 || _number  == 7) {
      return false;
    } else {
      return true;
    }
  }

  @override
  String toString() {
    if (isWorkingDay) {
      return 'weekday $_number which is working';
    } else {
      return 'weekday $_number which is holiday';
    }
  }
}
