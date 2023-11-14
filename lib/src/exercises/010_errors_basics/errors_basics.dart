import 'dart:ffi';
import 'package:collection/collection.dart';

void main() {
  // https://dart.dev/language/error-handling
  // https://dart.dev/guides/libraries/library-tour#exceptions

  // Exceptions/errors is a mechanism to signal to callers that something went wrong. It can be compared to returning
  // null or some special value, but exceptions are more powerful and flexible. Consider this code:
  // var file = File('some_data_file.dat');
  // List<MyData>? data = readData(file);
  // if (data == null) {
  //  // handle error

  // This is the style of error handling used in C and other languages without exceptions.
  // It has several drawbacks and limitations:
  // - it's not clear what kind of error happened (file not found, no permission to read file,
  // data in file doesn't match expected format, given file is not a file but a directory, etc)
  // - calling code MUST check the result to work properly, even if it can't do anything about the error
  // Imagine that code above was written inside func4, and call stack looks like this:
  // func1(func2(func3(func4())));
  // If error can be dealt with only in func1, then everywhere in func2, func3 and func4 we need to check the result
  // and each of that function must return null or some special value to indicate that error happened.
  // - it's not clear where the error happened, so if we log it, developers will not be able to easily find the exact
  // place causing the error

  // Three types of errors:

  // - exceptions - expected errors that are supposed to be handled by calling code, in other words, these kind of
  // errors are recoverable. Examples: backend is not available and retrying later should help, user entered invalid
  // data and we can ask him to enter it again, file is not found and we can ask user to specify correct path.
  // https://api.dart.dev/stable/3.1.5/dart-core/Exception-class.html
  // https://api.flutter.dev/flutter/dart-core/Exception-class.html

  // - errors - unrecoverable errors which are not supposed to be handled by calling code (except some kind of
  // journaling - log error, increment some error counter in DB, etc). In case of such errors, calling code can't do
  // anything to fix it, so in most cases there's no sense in handling such errors and just let the app crash.
  // The only notable exception is NoSuchMethodError, which is thrown when calling non-existing method on object.
  // Catching NoSuchMethodError and handling it may be useful for some dynamic programming scenarios.
  // Examples: out of memory, stack overflow, function not found, concurrent modification of
  // collection (it's a mistake in the compiled code, caller can't fix it anyhow), required driver doesn't work,
  // type of variable is not what we expect, etc.
  // https://api.flutter.dev/flutter/dart-core/Error-class.html
  // https://api.flutter.dev/flutter/dart-core/Error-class.html

  // - arbitrary objects thrown as exception - should never be used in normal code, useful only for tests and
  // debugging, where simplicity and conciseness is needed.

  throwExceptions();
  catchExceptions();
  catchFinally();
  asserts();
}

void throwExceptions() {
  // 1. Create following functions:
  // - double parseIncome(String income) - parses "income" string and returns double value. If income is negative
  // then it should throw an Exception with message "Negative income is not allowed".
  print('\n***throwExceptions1.1***\n');
  double parseIncome(String income) {
    var result = double.parse(income);
    if (result < 0) {
      throw Exception('Negative income is not allowed');
    }
    return result;
  }

  var income = '2.55';
  print(parseIncome(income));
  income = '-2.55';
  //print(parseIncome(income)); //Runtime Exception: Negative income is not allowed

  // - List<String> readIncomes(String file) - supposed to read incomes from file, but for exercise purposes it
  // should simply either do the following depending on the path value:
  //  -- if path is "empty", it should return empty list
  //  -- if path is "not-found", it should throw an Exception with message "File not found"
  //  -- if path is "negative", it should return list with few negatives values
  //  -- if path is "good", it should return list with valid positive income values
  //  -- if path is "bad", it should return list that contains non-numbers
  print('\n***throwExceptions1.2***\n');
  List<String> readIncomes(String file) {
    switch (file) {
      case "empty":
        return [];
      case "not-found":
        throw Exception('File not found');
      case "negative":
        return ['-11', '-22', '-23'];
      case "good":
        return ['12', '42', '13'];
      case "bad":
        return ['File', 'contains', 'non-numbers'];
      default:
        throw Exception('An unknown problem has occurred');
    }
  }

  // - List<double> readAndParseIncomes(String path) - reads incomes from file and parses them. Combination of
  //   "readIncomes" and "parseIncome" functions.
  print('\n***throwExceptions1.3***\n');
  List<double> readAndParseIncomes(String path) {
    var result =
        readIncomes(path).map((incomeStr) => parseIncome(incomeStr)).toList();
    return result;
  }

  // Unhandled exception:
  // Exception: File not found
  // #0      throwExceptions.readIncomes (package:sandbox/src/exercises/010_errors_basics/errors_basics.dart:83:9)
  // #1      throwExceptions.readAndParseIncomes (package:sandbox/src/exercises/010_errors_basics/errors_basics.dart:100:9)
  // #2      throwExceptions (package:sandbox/src/exercises/010_errors_basics/errors_basics.dart:104:9)
  // #3      main (package:sandbox/src/exercises/010_errors_basics/errors_basics.dart:46:3)
  //print(readAndParseIncomes('not-found'));

  print(readAndParseIncomes('good'));

  // Unhandled exception:
  // FormatException: Invalid double
  // File
  // #0      double.parse (dart:core-patch/double_patch.dart:112:28)
  // #1      throwExceptions.parseIncome (package:sandbox/src/exercises/010_errors_basics/errors_basics.dart:58:25)
  // #2      throwExceptions.readAndParseIncomes.<anonymous closure> (package:sandbox/src/exercises/010_errors_basics/errors_basics.dart:100:46)
  // #3      MappedListIterable.elementAt (dart:_internal/iterable.dart:415:31)
  // print(readAndParseIncomes('bad'));

  // Unhandled exception:
  // Exception: Negative income is not allowed
  //print(readAndParseIncomes('negative'));

  print(readAndParseIncomes('empty'));

  // - double sumIncomes(List<int> income, double taxRate, double exchangeRate) - sums all values in "income" list,
  // then applies tax and exchange rate and returns result. If it encounters negative value in "income" list, it
  // should throw an Exception with message "Negative income is not allowed".
  print('\n***throwExceptions1.4***\n');

  double sumIncomes(List<double> incomes,
      [double taxRate = 0.18, double exchangeRate = 31.5]) {
    return incomes.reduce((sum, element) {
      if (element < 0) {
        throw Exception('Negative income is not allowed');
      }
      return sum + (element * (1 - taxRate) * exchangeRate);
    });
    // var incomesSum = 0;
    // for (var income in incomes) {
    //   if (income < 0) {
    //     throw Exception('Negative income is not allowed');
    //   }
    //   incomesSum += income;
    // }
    // var afterTaxes = incomesSum * (1 - taxRate);
    // return afterTaxes * exchangeRate;
  }

  var incomes = [562.2, 781.3, 355.6, 567.0];
  // incomes = [562, 781, -355, 567]; //Runtime Exception: Negative income is not allowed
  print(sumIncomes(incomes, 0.25, 31.25));

  // - double sumIncomesFromFile(String path, double taxRate, double exchangeRate) - reads and parses incomes from
  // file, then sums them, applies tax and exchange rate and returns result. Combination of "readAndParseIncomes"
  // and "sumIncomes" functions.
  // List<double>
  print('\n***throwExceptions1.5***\n');
  double sumIncomesFromFile(String path, double taxRate, double exchangeRate) {
    var incomes =
        readIncomes(path).map((incomeStr) => parseIncome(incomeStr)).toList();
    return sumIncomes(incomes, taxRate, exchangeRate);
  }
  // Unhandled exception:
  // Exception: File not found
  // sumIncomesFromFile("not-found", 0.24, 31.5);

  // Unhandled exception:
  // FormatException: Invalid double
  // sumIncomesFromFile('bad', 0.3, 32.3);

  // 2. Create a function "void printSumIncomes(List<String> files)" which will print incomes sums from files.
  // Try it with good and bad file paths and observe results. Examine stack traces carefully.
  print('\n***throwExceptions2***\n');
  void printSumIncomes(List<String> files) {
    var incomesStrLists = files.map((path) => readIncomes(path));
    var sumList = [];
    var incomesDoubleLists = [];
    for (var incomes in incomesStrLists) {
      var doubleIncomes = incomes.map((income) => parseIncome(income));
      incomesDoubleLists.add(doubleIncomes);
    }
    for (var incomes in incomesDoubleLists) {
      sumList.add(sumIncomes(incomes.toList()));
      // sumList.add(incomes.reduce((sum, income) {
      //    if (income < 0) {
      //      throw Exception('Negative income is not allowed');
      //    }
      //    return sum + income;
      //  }));
    }
    print(sumList);
  }

  // var listFiles = ['good', 'good', 'bad']; //FormatException: Invalid double
  // var listFiles = ['good', 'good', 'bhghgghgh']; //Exception: An unknown problem has occurred
  var listFiles = ['good', 'good'];
  printSumIncomes(listFiles);
}

void catchExceptions() {
  // https://dart.dev/language/error-handling#catch

  // 1. Create function "printSumIncomesSafe" which is a variation of "printSumIncomes" but it should catch each
  // failed file and print message "failed to read incomes: <file path>". Unlike unsafe version, this new safe function
  // should not stop processing other files if it encounters a problem. Try calling it with different types of files.
  print('\n***catchExceptions1***\n');
  void printSumIncomesSafe(List<String> files) {
    for (var file in files) {
      try {
        var sum = sumIncomesFromFile(file, 0.23, 30.45);
        print(sum);
        //} on FormatException catch (ex, s) { //catch is only FormatException
        // } catch (ex, s) { //catch ALL objects (including  Errors, Strings, Null and any arbitrary class)
      } on Exception catch (ex, s) {
        //catch all Exceptions
        print('$ex \n $s');
      }
    }
  }

  var listFiles = ['good', 'good', 'bad', 'bhjl', 'not-found'];
  printSumIncomesSafe(listFiles);

  // 2. Create function "printSumIncomesSafe2" which is a variation of "printSumIncomesSafe" but it should catch
  // two types of exceptions - FormatException and Exception. FormatException should be handled by printing message
  // "invalid number in file: <file path>", Exception should be handled by printing
  // message "failed to read incomes: <file path>".
  print('\n***catchExceptions2***\n');
  void printSumIncomesSafe2(List<String> files) {
    for (var file in files) {
      try {
        var sum = sumIncomesFromFile(file, 0.23, 30.45);
        print(sum);
      } on FormatException {
        print("invalid number in file '$file'");
      } on Exception {
        print("failed to read incomes '$file'");
      }
    }
  }

  printSumIncomesSafe2(listFiles);

// 3. Create a function "printSumIncomesSafe3" which is same as "printSumIncomesSafe2" but it should also capture
// exception object and add it to error messages. So error messages are like "invalid number in file: <file path>,
// exception: <exception object>" and "failed to read incomes: <file path>, exception: <exception object>".
  print('\n***catchExceptions3***\n');
  void printSumIncomesSafe3(List<String> files) {
    for (var file in files) {
      try {
        var sum = sumIncomesFromFile(file, 0.23, 30.45);
        print(sum);
      } on FormatException catch (ex) {
        print("invalid number in file '$file' ($ex)");
      } on Exception catch (ex) {
        //catch all Exceptions
        print("failed to read incomes '$file' ($ex)");
      }
    }
  }

  printSumIncomesSafe3(listFiles);

// 4. Create a function "printSumIncomesSafe4" which is same as "printSumIncomesSafe3" but it should also capture
// stacktraces. Print stacktraces in error messages.
  print('\n***catchExceptions4***\n');
  void printSumIncomesSafe4(List<String> files) {
    for (var file in files) {
      try {
        var sum = sumIncomesFromFile(file, 0.23, 30.45);
        print(sum);
      } on FormatException catch (ex, s) {
        print("invalid number in file '$file' ($ex) \nStacktrace: \n$s");
      } on Exception catch (ex, s) {
        print("failed to read incomes '$file' ($ex) \nStacktrace: \n$s");
      }
    }
  }

  printSumIncomesSafe4(listFiles);

// 5. Create a function "printSumIncomes5" (without "safe") which is similar to printSumIncomesSafe3, but it should
// re-throw captured exceptions after printing messages. Use "rethrow" keyword. Observe stack traces carefully.
  print('\n***catchExceptions5***\n');
  void printSumIncomesSafe5(List<String> files) {
    for (var file in files) {
      try {
        var sum = sumIncomesFromFile(file, 0.23, 30.45);
        print(sum);
      } on FormatException catch (ex) {
        print("invalid number in file '$file' ($ex)");
        //       rethrow; //Unhandled exception: FormatException: Invalid double. The program was stopped
      } on Exception catch (ex) {
        //catch all Exceptions
        print("failed to read incomes '$file' ($ex)");
        //       rethrow;
      }
    }
  }

  printSumIncomesSafe5(listFiles);
}

void catchFinally() {
// https://dart.dev/language/error-handling#finally

// Is used to have guaranteed code execution after try-catch block, regardless of whether exception was thrown or not.
// It's useful for releasing resources, closing files, etc. For example, if you opened a DB connection and performed
// processing of requested data, in the end of the processing you should close the connection no matter if data
// processing was successful or not. DB connection should be always closed, otherwise you may have "resource leak",
// i.e. when your application creates more and more connections and eventually runs out of them or slows down, or
// DB server runs out of connections and stops working, or app runs out of memory, etc.

// 1. Create three new fake functions - "List<String> readFilesFromDB()", "void saveIncomesToDB()" and
// "void closeDBConnection()". Put only print statements inside those functions, we're not going to work with real
// database, just simulate this scenario. Now combine these new functions with different variants of "printSumIncomes"
// functions from previous exercises. Put "closeDBConnection()" call in "finally" block and observe how it's being
// always called regardless of whether exception was thrown or not.
  print('\n***catchFinally***\n');
  List<dynamic> readFilesFromDB(List<String> files) {
    var sumList = [];
    for (var file in files) {
      try {
        openDBConnection();
        var sum = sumIncomesFromFile(file, 0.23, 30.45);
        saveIncomesFromDB(sum, sumList);
      } on FormatException catch (ex) {
        print("invalid number in file '$file' ($ex)");
        rethrow;
      } on Exception catch (ex) {
        print("failed to read incomes '$file' ($ex)");
        rethrow;
      } finally {
        closeDBConnection(); //The program stops running after executing this command for the current iteration
      }
    }
    return sumList;
  }

  var listFiles = ['good', 'good', 'bad', 'bhjl', 'not-found'];
  readFilesFromDB(listFiles);
}

List<dynamic> saveIncomesFromDB(var incomesSum, List sumList) {
  print('$incomesSum saved to DB');
  sumList.add(incomesSum);
  return sumList;
}

void closeDBConnection() {
  print('DB closed');
}

void openDBConnection() {
  print('DB opend');
}

void asserts() {
// https://dart.dev/language/error-handling#assert

// Since asserts checks can be toggled off with VM flags, asserts should never be used in normal code to check
// for invalid arguments, user input validation, preconditions check, etc. To be on a safer side, it's better to never
// use asserts in normal code at all. Instead, use regular "if" with exceptions for this purpose.
// Asserts are useful in tests and for in-field debugging (when it's impossible to run app in debug mode and attach
// to it with debugger).

// 1. Just play around with assert statements. Try both variants:
// - assert(<bool-expression>);
// - assert(<bool-expression>, <error-message>);

//   Во время разработки используйте оператор утверждения assert(<condition>, <optionalMessage>);— — чтобы прервать нормальное выполнение, если логическое условие ложно.
//
// // Make sure the variable has a non-null value.
//   assert(text != null);
//
// // Make sure the value is less than 100.
//   assert(number < 100);
//
// // Make sure this is an https URL.
//   assert(urlString.startsWith('https'));
//   Чтобы прикрепить сообщение к утверждению, добавьте строку в качестве второго аргумента assert (необязательно с завершающей запятой ):
//
//   assert(urlString.startsWith('https'),
}

double parseIncome(String income) {
  var result = double.parse(income);
  if (result < 0) {
    throw Exception('Negative income is not allowed');
  }
  return result;
}

List<String> readIncomes(String file) {
  switch (file) {
    case "empty":
      return [];
    case "not-found":
      throw Exception('File not found');
    case "negative":
      return ['-11', '-22', '-23'];
    case "good":
      return ['12', '42', '13'];
    case "bad":
      return ['File', 'contains', 'non-numbers'];
    default:
      throw Exception('An unknown problem has occurred');
  }
}

double sumIncomes(List<double> incomes,
    [double taxRate = 0.18, double exchangeRate = 31.5]) {
  return incomes.reduce((sum, element) {
    if (element < 0) {
      throw Exception('Negative income is not allowed');
    }
    return sum + (element * (1 - taxRate) * exchangeRate);
  });
}

double sumIncomesFromFile(String path, double taxRate, double exchangeRate) {
  var incomes =
      readIncomes(path).map((incomeStr) => parseIncome(incomeStr)).toList();
  return sumIncomes(incomes, taxRate, exchangeRate);
}
