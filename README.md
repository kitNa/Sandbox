# dart sandbox

Dart project to learn the language, do exercises, and keep short notes about specific concepts.

## dart project layout conventions

https://dart.dev/tools/pub/package-layout

```
<project>
  pubspec.yaml   - project build config file (dependencies, executables, etc)
  pubspec.lock   - generated by pub/dart, contains exact versions of dependencies declared as ranges in pubspec.yaml
                   e.g. if pubspec.yaml contains "foo: ^1.2.3" then pubspec.lock will contain "foo: 1.2.7" if "1.2.7" 
                   was the latest available version when "pub get"/"pub update" was executed
  lib/           - dart files with library code (without "main()" method), 99% of the logic is here
                 - dart files in this folder are exported by the package, i.e. can be imported by 
                   other packages/projects
    src/         - dart files with library code that should not be exported, internal implementation
  bin/           - dart files with main() function, entry points for the project
  test/          - tests
  example/       - runnable examples
  doc/           - documentation
    api/         - generated documentation, never commit it, should be added to .gitignore
  .dart_tool/    - generated by pub/dart, never commit this, should be added to .gitignore
```

## naming conventions

https://dart.dev/effective-dart/style

- files, folders, packages, imports - lower_snake_case
  https://dart.dev/effective-dart/style#do-name-packages-and-file-system-entities-using-lowercase-with-underscores

```
// good
foo_bar.dart
some_folder/

// bad
fooBar.dart
FooBar.dart
foo-bar.dart
some-folder/
```

- classes
  https://dart.dev/effective-dart/style#do-name-types-using-uppercamelcase

```
// good
class SomeClass {
  // ...
}

// bad
class someClass {
  // ...
}
```

