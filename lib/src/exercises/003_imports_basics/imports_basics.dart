// imports need to be added here

Future<void> main() async {
  // NOTE: ignore those Future, async and await keywords for now, they will be covered later. We need them here for
  // making http calls.

  // https://dart.dev/language/libraries
  // only basic importing is covered here, how to build your own library will be covered later after OOP to make it
  // all more clear and useful

  // there are five types of libraries you can use in dart project:
  //  - built-in libraries (dart:core, dart:io, dart:html, etc.) - they are part of dart sdk, which you install with
  //     dart and which are available in the dart runtime (dart vm)
  //  - public third-party libraries (package:http, package:angular, etc.) - they are not part of dart sdk, but they are
  //     published to central repository (pub.dev) and you can use them in your project by adding them to pubspec.yaml
  //  - private organization libraries (package:my_company/my_library, etc.) - these libraries are published to private
  //     repository, usually available for organization members only, or this can be your own repository hosted for
  //     personal needs
  //  - local separate libraries (package:another_project/my_library, etc.) - these libraries are not published
  //     anywhere, they exist as separate projects in other folders on your computer, but they are not part of your
  //     current project. You can use them by adding them to pubspec.yaml and specifying path to them.
  //  - local project libraries (package:my_project/my_library, etc.) - these libraries are not published anywhere,
  //     they exist in the same project you're working on. I.e. project can be split into multiple packages, which
  //     work as separate building blocks of your application.

  importBuiltInLibrary();
  importWithPrefix();
  importPieces();
  await importPublicLibrary();
}

void importBuiltInLibrary() {
  // their names are prefixed with "dart:"
  // import 'dart:html';

  // 1. import dart:math library and use it to calculate square root of 9

  // 2. import dart:io library and use it to print "THIS IS ERROR" to the "stderr"
  //   stderr   <<-- global object you import from dart:io library that you can use to write to standard error stream
  //   more info about process IO streams: https://stackoverflow.com/questions/3385201/confused-about-stdin-stdout-and-stderr
  // example how to write to stdout: stdout.writeln('THIS GOES TO STANDARD OUTPUT STREAM');
}

void importWithPrefix() {
  // you can use prefix to avoid name collisions
  // import 'dart:io' as io;

  // 1. import dart:io library with prefix "io" and use it to print "THIS IS ERROR" to the "stderr"
  //    note that when you have two imports for the same library - one with prefix and one without - you can use it
  //    in both ways:
  //    stdout.writeln('THIS GOES TO STANDARD OUTPUT STREAM');
  //    io.stdout.writeln('THIS GOES TO STANDARD OUTPUT STREAM');

  // 2. import dart:math library with prefix "math" and use it to calculate sine of 7.5 radians
}

void importPieces() {
  // I'll use word "element" here to avoid confusion with "part" in libraries terms

  // you can import only specific elements (functions, global objects, classes, etc.) of the library with
  // import 'dart:io' show Platform, stdin, stdout, stderr;
  // or you can import everything except some elements with
  // import 'dart:io' hide HttpClient, HttpServer;

  // to learn what elements are exported by the library, the only way I found is to open the library file and look

  // 1. Remove all imports list first. Then import only "stderr" from dart io library, and print
  //    "k8 is gr8 (this is not an error)" to it. Now try to print that message to "stdout" and check what compiler
  //    thinks about using elements that were not imported.

  // 2. Remove all imports list first. Now import everything from dart:io library except "stdout". And try to print
  //    same "k8 is gr8" message to "stderr". Now print it to "stdout" and see how it's not imported.
}

Future<void> importPublicLibrary() async {
  // You can import public libraries from pub.dev.
  // For example you can import "git" library - https://pub.dev/packages/git
  // How to add it to your project - https://pub.dev/packages/git/install
  // NOTE: don't use "dart add ..." or "flutter add ..." commands to better understand how it works and learn it, edit
  //  pubspec.yaml file manually instead:
  // dependencies:
  //   git: ^2.2.1
  // And then run "dart pub get" to download it. Note that when you run it, pub will also print report about any
  // libraries that have new versions available, so you can update them if you want.

  // 1. Add "http" library to the project - https://pub.dev/packages/http . And import it with prefix "http" (like
  // in documentation example). Then make a GET http request to google.com and print response status and body length.
  // And do the same for dart.dev website. Print which response body size is bigger, and how much.

  // You can use this snippet as an example of making request and handling response
  // (we'll learn what "await" means later):
  // var resp = await http.get(Uri.parse('https://dart.dev'));
  // print('response headers: ${resp.headers}');
}
