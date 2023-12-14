extension MyStringOperatorsExtension on String {
  String operator -(String letters) {
    var newString = this;
    for (var i = 0; i < letters.length; i++) {
      newString = newString
          .replaceAll(letters[i].toLowerCase(), '')
          .replaceAll(letters[i].toUpperCase(), '');
    }
    return newString;
  }
}
