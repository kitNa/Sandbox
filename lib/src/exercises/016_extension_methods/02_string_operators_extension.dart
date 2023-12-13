extension MyStringOperatorsExtension on String {
  String operator -(String letters) {
    var newString = this.toLowerCase();
    for(var i = 0; i < letters.length; i++) {
      newString = newString.replaceAll(letters[i].toLowerCase(), '');
    }
    return newString;
  }
}
