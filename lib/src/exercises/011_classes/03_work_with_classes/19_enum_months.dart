void main() {
  for (var month in MonthOfYear.values) {
    print('${month._number} ${month.name} - $month');
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

  final int _number;
  final String _season;
  final bool _isSchoolMonth;

  const MonthOfYear(this._number, this._season, this._isSchoolMonth);

  @override
  String toString() {
    if (_isSchoolMonth) {
      return '$_season, is time to go to school';
    } else {
      return '$_season, is vacation time';
    }
  }
}
