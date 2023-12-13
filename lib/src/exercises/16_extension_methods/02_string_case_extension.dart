extension MyStringCaseExtension on String {
  String capitalize() {
    var capitalizeString = this[0].toUpperCase() + substring(1);
    return capitalizeString;
  }
}
