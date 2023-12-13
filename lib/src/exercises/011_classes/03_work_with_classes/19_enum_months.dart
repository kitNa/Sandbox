void main() {
  for (var month in MonthOfYear.values) {
    print('${month.number} ${month.name} - $month');
  }
}

enum MonthOfYear {
  january (1, 'winter', true),
  february (2, 'winter', true),
  march (3, 'spring', true),
  april (4, 'spring', true),
  may (5, 'spring', true),
  june (6, 'summer', false),
  july (7, 'summer', false),
  august (8, 'summer', false),
  september (9, 'autumn', true),
  october (10, 'autumn', true),
  november (11, 'autumn', true),
  december (12, 'winter', true);

  final int number;
  final String season;
  final bool isSchoolMonth;

  const MonthOfYear(this.number, this.season, this.isSchoolMonth);

  @override
  String toString() {
    if (isSchoolMonth) {
      return '$season, is time to go to school';
    } else {
      return '$season, is vacation time';
    }
  }
}
