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
  // - List<String> readIncomes(String file) - supposed to read incomes from file, but for exercise purposes it
  // should simply either do the following depending on the path value:
  //  -- if path is "empty", it should return empty list
  //  -- if path is "not-found", it should throw an Exception with message "File not found"
  //  -- if path is "negative", it should return list with few negatives values
  //  -- if path is "good", it should return list with valid positive income values
  //  -- if path is "bad", it should return list that contains non-numbers
  // - List<double> readAndParseIncomes(String path) - reads incomes from file and parses them. Combination of
  //   "readIncomes" and "parseIncome" functions.
  // - double sumIncomes(List<int> income, double taxRate, double exchangeRate) - sums all values in "income" list,
  // then applies tax and exchange rate and returns result. If it encounters negative value in "income" list, it
  // should throw an Exception with message "Negative income is not allowed".
  // - double sumIncomesFromFile(String path, double taxRate, double exchangeRate) - reads and parses incomes from
  // file, then sums them, applies tax and exchange rate and returns result. Combination of "readAndParseIncomes"
  // and "sumIncomes" functions.

  // 2. Create a function "void printSumIncomes(List<String> files)" which will print incomes sums from files.
  // Try it with good and bad file paths and observe results. Examine stack traces carefully.
}

void catchExceptions() {
  // https://dart.dev/language/error-handling#catch

  // 1. Create function "printSumIncomesSafe" which is a variation of "printSumIncomes" but it should catch each
  // failed file and print message "failed to read incomes: <file path>". Unlike unsafe version, this new safe function
  // should not stop processing other files if it encounters a problem. Try calling it with different types of files.

  // 2. Create function "printSumIncomesSafe2" which is a variation of "printSumIncomesSafe" but it should catch
  // two types of exceptions - FormatException and Exception. FormatException should be handled by printing message
  // "invalid number in file: <file path>", Exception should be handled by printing
  // message "failed to read incomes: <file path>".

  // 3. Create a function "printSumIncomesSafe3" which is same as "printSumIncomesSafe2" but it should also capture
  // exception object and add it to error messages. So error messages are like "invalid number in file: <file path>,
  // exception: <exception object>" and "failed to read incomes: <file path>, exception: <exception object>".

  // 4. Create a function "printSumIncomesSafe4" which is same as "printSumIncomesSafe3" but it should also capture
  // stacktraces. Print stacktraces in error messages.

  // 5. Create a function "printSumIncomes5" (without "safe") which is similar to printSumIncomesSafe3, but it should
  // re-throw captured exceptions after printing messages. Use "rethrow" keyword. Observe stack traces carefully.
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
}
