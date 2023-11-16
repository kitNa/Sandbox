void main() {
  // var user = User(name: 'John', age: 30);
  // var user = User("John", -30);  // validation EXCEPTION
  var user = User("John", 30, Gender.male);
  user.numLikes = 123;
  // user.age = -150; // invariant violation
  print("user created : $user"); // equivalent to print("user created : ${user.toString()}");
  print("user.numLikes : ${user.numLikes}");
  print("user.age : ${user.age}");

  var userPrinter = UserDebugPrinter(user);
  userPrinter.printUser();
}

enum Gender {
  male, female, other
}

// Invariant (constraints) - conditions that must be true for the class to be valid
// according to business rules (domain rules)
class User {

  // public member - accessible from outside of the class
  // no need to use special keyword (public, private, protected, etc.) in dart

  // _someMemberName - name starts with "_" (underscore), makes it private
  // "someMemberName" - any other name is public
  String name;

  // PRIVATE FIELDS:
  // private fields are accessible within the same *FILE* only, so semantically
  // dart has "file-private" access modifier
  int _age;
  int _numLikesField = 3 + 123;

  // private fields are NOTE accessible outside the file
  final Gender _gender;

  String get greetingPhrase {
    switch (_gender) {
      case Gender.male: return "Hello Sir";
      case Gender.female: return "Hello Madam";
      case Gender.other: return "Hello";
    }
  }

  int get numLikes {
    print("numLikes getter invoked");
    return _numLikesField;
  }

  set numLikes(int numLikes) => _numLikesField = numLikes;

  set age(int age) {
    if (age <= 0) {
      throw Exception("age cannot be negative");
    }
    _age = age;
  }

  int get age => _age;

  @override
  String toString() {
    return 'User{name: $name, age: $age, numLikes: $numLikes}';
  }

  String _detailedToString() {
    return 'User{name: $name, _age: $_age, _numLikesField: $_numLikesField, _gender: $_gender}';
  }

  String _someFunc() {
    return "someFunc";
  }

  // option 1: positional parameters  (notice that _numLikesField is already initialized,
  // we don't need to specify it here)
  User(this.name, this._age, this._gender) {
    if (_age <= 0) {
      throw Exception("age cannot be negative");
    }
  }

// option 2: positional params + initializer list
// User(String nameParam, int ageParam)
//     : name = nameParam,
//       age = ageParam;

// option 3: named *required* parameters
// User({required String this.name, required int this.age});

// option 4: named parameters with initial values
// User({this.name = 'UNNAMED', this.age = 0});
}




class UserDebugPrinter {
  final User user;

  UserDebugPrinter(this.user);

  void printUser() {
    // UserDebugPrinter can access "User._age" field because they are in
    // the same file. Be careful with accessing private members from "friends"
    // in the same file, you can easily break the invariant or business rules.
    user._age = -123;

    // Instead of doing direct field write ^^^, better to use setter:
    // user.age = -123;  // will fail because of invariant violation


    print("custom user.name : ${user.name}");
    print("custom user.age  : ${user.age}");

    // UserDebugPrinter can access "User._gender" field because they are in
    // the same file.
    print("custom user.gend : ${user._gender}");
    print("custom _detailed : ${user._detailedToString()}");
  }
}
