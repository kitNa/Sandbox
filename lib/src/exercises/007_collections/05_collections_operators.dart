void main() {
  // https://dart.dev/language/collections#operators

  spreadOperator();
  controlFlowOperators();
}

void spreadOperator() {
  //  Create a list of 3 favorite movies/cartoons:
  //  - your
  //  - your husband
  //  - your kid
  var myFavoriteMovies = [
    'The Artist',
    'The Pianist',
    'The Notebook',
    'Moscati',
    'Dragonfly'
  ];
  var myHusbandFavoriteMovies = [
    'Green Mile',
    'Silence of the Lambs',
    'Hannibal',
    'Knives Out',
    'The Beginning'
  ];
  var myKidFavoriteMovies = [
    'Mia and Me',
    'The Little Mermaid',
    'Winx Fairies',
    'Three Cats',
    'Mowgli'
  ];

  // 1. Create "allFavorites" list combined from all 3 lists above. Used spread operator.
  print('\n***spreadOperator1***\n');
  var allFavoritesMovies = [
    ...myKidFavoriteMovies,
    ...myHusbandFavoriteMovies,
    ...myFavoriteMovies
  ];
  print(allFavoritesMovies);

  // 2. Create a list of your and husband's favorite movies by combining the lists above using spread operator.
  // And append 'The Matrix' movie at the end.
  print('\n***spreadOperator2***\n');
  var moviesToSee = [
    ...myFavoriteMovies,
    ...myHusbandFavoriteMovies,
    'The Matrix'
  ];
  print(moviesToSee);

  // 3. Do the same, but put 'The Matrix' movie at the beginning.
  print('\n***spreadOperator3***\n');
  moviesToSee = ['The Matrix', ...myFavoriteMovies, ...myHusbandFavoriteMovies];
  print(moviesToSee);

  // 4. Now combine all 3 favorites lists with:
  // - 'Bee Movie' at the beginning
  // - 'The Matrix' in the middle
  // - 'Moana' at the end
  print('\n***spreadOperator4***\n');
  moviesToSee = [
    'Bee Movie',
    ...myFavoriteMovies,
    'The Matrix',
    ...myHusbandFavoriteMovies,
    'Moana'
  ];
  print(moviesToSee);

  // 5. null-safe spread-operator.
  // Now make nullable copy of your kid's favorite movies list. And repeat previous exercise but with
  // null-safe spread operator.
  print('\n***spreadOperator5***\n');
  List<String>? myKidMovies = myKidFavoriteMovies;
  moviesToSee = ['Bee Movie', ...myKidMovies, 'Moana'];
  myKidMovies = null;
  moviesToSee = ['Bee Movie', ...?myKidMovies, 'Moana']; //[Bee Movie, Moana]
  print(moviesToSee);
}

void controlFlowOperators() {
  // https://dart.dev/language/collections#control-flow-operators

  // 1. Define "includeMargo" boolean variable. Create a list of your 3 favorite names and optionally include
  // 'Margo' name to the list if "includeMargo" is true. Use "if" list operator.
  print('\n***controlFlowOperators1***\n');
  var includeMargo = true;
  var names = ['Katya', 'Sasha', 'Danya', if (includeMargo) 'Margo'];
  print(names);

  // 2. Define "isGirl" boolean variable. Create a list of your 3 favorite names and include
  // 'Margo' name if "isGirl" is true, otherwise include 'Max'. Use "if-else" list operator.
  // var list = ['one', if (isOdd) 'three' else 'another', 'four'];
  print('\n***controlFlowOperators2***\n');
  var isGirl = false;
  names = ['Katya', 'Sasha', 'Danya', if (isGirl) 'Margo' else 'Max'];
  print(names);

  // 3. Define "bodyTemperature" variable. Create a list of suggested drinks: 'water', 'juice', and next depending on
  // the body temperature - >38.5 - 'medicine', >37.0 - 'tea', >36.6 - 'milk', else - hot water.
  // Use "if case" list operator.
  // var list = ['one', if (myVar case >100) 'high' else 'low', 'four'];
  print('\n***controlFlowOperators3***\n');
  var temperature = 37.7;
  var suggestedDrinks = [
    'water',
    'juice',
    if (temperature case > 38.5) 'medicine',
    if (temperature case > 37.0) 'tea',
    if (temperature case > 36.6) 'milk'
  ];
  print(suggestedDrinks);

  // 4. You have a list of numbers - [1, 2, 3]. Create new list with following numbers:
  // - 100,
  // - all numbers from the list above + 100,
  // - 200,
  // - 300
  // Use "for ()" list operator.
  print('\n***controlFlowOperators4***\n');
  var numbers = [1, 2, 3];
  var listNumbers = [100, for (var number in numbers) number + 100, 200, 300];
  print(listNumbers);

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
  print('\n***controlFlowOperators5***\n');
  var movies = [
    'Green Mile',
    'Silence of the Lambs',
    'Hannibal',
    'Knives Out',
    'The Beginning'
  ];
  var moviesFormatted = [
    movies.first.toUpperCase(),
    for (var i = 1; i < movies.length - 1; i++) movies[i].toLowerCase(),
    movies.last.toUpperCase()
  ];
  print(moviesFormatted);
}
