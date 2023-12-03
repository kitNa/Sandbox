import 'package:mongo_dart/mongo_dart.dart';

void main() {
  // https://dart.dev/language/error-handling

  // this may be REST api handler code
  var id1 = '1';
  var req1 =
      RegistrationRequest(id1, 'email1@example.com', 'paadsfiasjdfiosas');
  try {
    registerUser(id1, req1);
  } on InvalidEmailException catch (e) {
    print('invalid email: ${e.email}');
  } on RegistrationException {
    print('user registration failed');
  } on UserManagementException {
    print('something went wrong');
  }
  print('------------------');

  // this may be UI handler code
  var id2 = '2';
  var req2 = RegistrationRequest(id2, 'email1@example.com', 'passsword1isudhf');
  try {
    registerUser(id2, req2);
  } on InvalidEmailException catch (e) {
    print('invalid email: ${e.email}');
  } on EmailAlreadyInUseException catch (e) {
    print('email ${e.email} is already in use');
  } on RegistrationException {
    print('user registration failed');
  } on UserManagementException {
    print('something went wrong');
  }
  print('------------------');

  var id3 = '3';
  var req3 = RegistrationRequest(id3, 'another@example.com', 'abc');
  try {
    registerUser(id3, req3);
  } on InvalidEmailException catch (e) {
    print('invalid email: ${e.email}');
  } on EmailAlreadyInUseException catch (e) {
    print('email ${e.email} is already in use');
  } on PasswordTooShortException catch (e) {
    print('password ${e.password} is too short, min length is ${e.minLength}');
  } on RegistrationException {
    print('user registration failed');
  } on UserManagementException {
    print('something went wrong');
  }
  print('------------------');

  // Imagine that following code is called from subsytem that imports user from CVS file provided by business partners
  // who want to register their employees in your system. We don't care about exact root causes here, we just need
  // to skip invalid users (failed to register) and continue with next user. But at the same time, if something ELSE
  // goes wrong (generic UserManagementException), we want to stop the whole process and report error.
  var id4 = '4';
  var req4 = RegistrationRequest(
      id4, 'yet.another@example.com', 'odsjfaoijfoiasjdfoisdjoijasdoifj');
  try {
    registerUser(id4, req4);
  } on RegistrationException {
    print('user registration failed');
  }
  print('------------------');

  try {
    login(req1);
  } on InvalidEmailException catch (e) {
    print('Email ${e.email} is invalid');
  } on NoSuchEmailException catch (e) {
    print('There is no such email in the database: ${e.email}');
  } on IncorrectPasswordException catch (e) {
    print('Incorrect password entered: ${e.password}');
  } on LoginException catch (e) {
    print('Please review the entered data');
  }
  print('------------------');

  try {
    login(req3);
  } on InvalidEmailException catch (e) {
    print('Email ${e.email} is invalid');
  } on NoSuchEmailException catch (e) {
    print('There is no such email in the database: ${e.email}');
  } on IncorrectPasswordException catch (e) {
    print('Incorrect password entered: ${e.password}');
  } on LoginException catch (e) {
    print('Please review the entered data');
  }
  print('------------------');

  var id5 = '5';
  var req5 = RegistrationRequest(id5, 'email1@example.com', 'margosha');
  try {
    login(req5);
  } on InvalidEmailException catch (e) {
    print('Email ${e.email} is invalid');
  } on NoSuchEmailException catch (e) {
    print('There is no such email in the database: ${e.email}');
  } on IncorrectPasswordException catch (e) {
    print('Incorrect password entered: ${e.password}');
  } on LoginException catch (e) {
    print('Please review the entered data');
  }
  print('------------------');

  var id6 = '6';
  var req6 = RegistrationRequest(id6, 'emailcom', 'margosha');
  try {
    login(req6);
  } on InvalidEmailException catch (e) {
    print('Email ${e.email} is invalid');
  } on NoSuchEmailException catch (e) {
    print('There is no such email in the database: ${e.email}');
  } on IncorrectPasswordException catch (e) {
    print('Incorrect password entered: ${e.password}');
  } on LoginException catch (e) {
    print('Please review the entered data');
  }
  print('------------------');

  var id7 = '7';
  var req7 = RegistrationRequest(id7, 'email1@example.com', 'passsword1isudhf');
  //Unhandled exception: Email email1@example.com is already exist in DB
  registerUser(id7, req7);
}

// UserManagement application
Set<String> registeredEmails = {};

void login(RegistrationRequest req) {
  if (!_isValidEmail(req.email)) {
    throw InvalidEmailException(req.requestId, req.email);
  }
  if (!_isEmailInDB(req.email)) {
    throw NoSuchEmailException(req.requestId, req.email);
  }
  if (!_passwordMatchesToDB(req.password)) {
    throw IncorrectPasswordException(req.requestId, req.password);
  }
  print('Login');
}

void registerUser(String requestId, RegistrationRequest req) {
  if (!_isValidEmail(req.email)) {
    throw InvalidEmailException(requestId, req.email);
  }
  if (_isPasswordShort(req.password)) {
    throw PasswordTooShortException(requestId, req.password, 8);
  }
  if (_isPasswordLong(req.password)) {
    throw PasswordTooLongException(requestId, req.password, 20);
  }
  if (_isPasswordWeak(req.password)) {
    throw WeakPasswordException(requestId, req.password);
  }
  if (_passwordHasUnsupportedCharacters(req.password)) {
    throw UnsupportedPasswordCharactersException(
        requestId, req.password, [' ']);
  }
  // we store new user in DB ....
  _saveUserInDB(requestId, req.email, req.password);
  print("user ${req.email} registered");
}

void _saveUserInDB(String requestId, String email, String password) {
  // we store new user in DB ....
  try {
    _dbLibraryInsert(email, password);
  } on UniqueConstraintViolationDBException {
    throw EmailAlreadyInUseException(requestId, email);
  }
  registeredEmails.add(email);
  print("user $email inserted in DB");
}

bool _isEmailInDB(String email) {
  return registeredEmails.contains(email);
}

void _dbLibraryInsert(String email, String password) {
  // imagine this exception comes from DB library, not from our code
  if (registeredEmails.contains(email)) {
    throw UniqueConstraintViolationDBException();
  }
}

bool _isValidEmail(String email) {
  return email.contains('@');
}

bool _isPasswordShort(String password) {
  return password.length < 8;
}

bool _isPasswordLong(String password) {
  return password.length > 20;
}

bool _isPasswordWeak(String password) {
  return password.contains('123');
}

bool _passwordHasUnsupportedCharacters(String password) {
  return password.contains(' ');
}

bool _passwordMatchesToDB(String password) {
  String artificialPassword = 'margosha';
  return password.toUpperCase() == artificialPassword.toUpperCase();
}

abstract interface class Request {
  String get requestId;
}

abstract class AbstractRequest implements Request {
  @override
  final String requestId;

  AbstractRequest(this.requestId);
}

class RegistrationRequest extends AbstractRequest {
  final String email;
  final String password;

  RegistrationRequest(super.requestId, this.email, this.password);
}

class LoginRequest extends AbstractRequest {
  final String email;
  final String password;

  LoginRequest(super.requestId, this.email, this.password);
}

// exceptions

class UserManagementException implements Exception {
  String requestId;

  UserManagementException(this.requestId);
}

class RegistrationException extends UserManagementException {
  RegistrationException(super.requestId);

  @override
  String toString() {
    return 'Registration was completed with an error';
  }
}

class PasswordException extends RegistrationException {
  String password;

  PasswordException(super.requestId, this.password);

  @override
  String toString() {
    return 'Password - $password has some problem';
  }
}

class WeakPasswordException extends PasswordException {
  WeakPasswordException(super.requestId, super.password);

  @override
  String toString() {
    return 'Password - $password is weak';
  }
}

class PasswordTooShortException extends PasswordException {
  int minLength;

  PasswordTooShortException(super.requestId, super.password, this.minLength);

  @override
  String toString() {
    return 'Password - $password is too short';
  }
}

class PasswordTooLongException extends PasswordException {
  int maxLength;

  PasswordTooLongException(super.requestId, super.password, this.maxLength);

  @override
  String toString() {
    return 'Password - $password is too long';
  }
}

class UnsupportedPasswordCharactersException extends PasswordException {
  List<String> unsupportedCharacters;

  UnsupportedPasswordCharactersException(
      super.requestId, super.password, this.unsupportedCharacters);

  @override
  String toString() {
    return 'Password - $password has unsupported characters';
  }
}

class EmailAlreadyInUseException extends RegistrationException {
  String email;

  EmailAlreadyInUseException(super.requestId, this.email);

  @override
  String toString() {
    return '$runtimeType: Email $email is already exist in DB';
  }
}

class InvalidEmailException extends RegistrationException {
  String email;

  InvalidEmailException(super.requestId, this.email);

  @override
  String toString() {
    return 'Email $email is invalid';
  }
}

class LoginException extends UserManagementException {
  LoginException(super.requestId);
}

class InvalidCredentialsException extends LoginException {
  InvalidCredentialsException(super.requestId);

  @override
  String toString() {
    return 'Request with ID $requestId has invalid credentials';
  }
}

class IncorrectPasswordException extends LoginException {
  String password;

  IncorrectPasswordException(super.requestId, this.password);

  @override
  String toString() {
    return 'Password - $password is incorrect';
  }
}

class NoSuchEmailException extends LoginException {
  String email;

  NoSuchEmailException(super.requestId, this.email);

  @override
  String toString() {
    return 'Email $email is not found in DB';
  }
}

// imagine this exception comes from DB library, not from our code
class UniqueConstraintViolationDBException implements Exception {}
