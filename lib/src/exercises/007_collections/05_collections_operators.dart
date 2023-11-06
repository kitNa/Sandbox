void main() {
  // https://dart.dev/language/collections#operators

  spreadOperator();
  controlFlowOperators();
}

void spreadOperator() {
  // 1. Create a list of 3 favorite movies/cartoons:
  //  - your
  //  - your husband
  //  - your kid

  // 2. Create "allFavorites" list combined from all 3 lists above. Used spread operator.

  // 5. Create a list of your and husband's favorite movies by combining the lists above using spread operator.
  // And append 'The Matrix' movie at the end.

  // 6. Do the same, but put 'The Matrix' movie at the beginning.

  // 7. Now combine all 3 favorites lists with:
  // - 'Bee Movie' at the beginning
  // - 'The Matrix' in the middle
  // - 'Moana' at the end

  // null-safe spread-operator.
  // Now make nullable copy of your kid's favorite movies list. And repeat previous exercise but with
  // null-safe spread operator.
}

void controlFlowOperators() {
  // https://dart.dev/language/collections#control-flow-operators

  // 1. Define "includeMargo" boolean variable. Create a list of your 3 favorite names and optionally include
  // 'Margo' name to the list if "includeMargo" is true. Use "if" list operator.

  // 2. Define "isGirl" boolean variable. Create a list of your 3 favorite names and include
  // 'Margo' name if "isGirl" is true, otherwise include 'Max'. Use "if-else" list operator.
  // var list = ['one', if (isOdd) 'three' else 'another', 'four'];

  // 3. Define "bodyTemperature" variable. Create a list of suggested drinks: 'water', 'juice', and next depending on
  // the body temperature - >38.5 - 'medicine', >37.0 - 'tea', >36.6 - 'milk', else - hot water.
  // Use "if case" list operator.
  // var list = ['one', if (myVar case >100) 'high' else 'low', 'four'];

  // 4. You have a list of numbers - [1, 2, 3]. Create new list with following numbers:
  // - 100,
  // - all numbers from the list above + 100,
  // - 200,
  // - 300
  // Use "for ()" list operator.

  // 5. Create a list of 5 favorite movies. Build a new list of movies with following formatting:
  // - first movie - in upper case
  // - second and all except last movie - in lower case
  // - last movie - in upper case
  /* DON"T COPY THIS CODE, just read it as a reference
  var movies = ['The Artist', 'The Pianist', 'The Notebook', 'Moscati', 'Dragonfly'];
  var moviesFormatted = [
    movies.first.toUpperCase(),
    for (var i = 1; i < movies.length - 1; i++) movies[i].toLowerCase(),
    movies.last.toUpperCase()
  ];
   */
}
