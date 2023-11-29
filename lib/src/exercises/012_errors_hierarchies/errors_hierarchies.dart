void main() {
  // https://dart.dev/language/error-handling

  // this may be REST api handler code
  var id1 = '1';
  var req1 = RegistrationRequest(id1, 'email1@example.com', 'paadsfiasjdfiosas');
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
  var req4 = RegistrationRequest(id4, 'yet.another@example.com', 'odsjfaoijfoiasjdfoisdjoijasdoifj');
  try {
    registerUser(id4, req4);
  } on RegistrationException {
    print('user registration failed');
  }
}

// UserManagement application
Set<String> registeredEmails = {};

void login(String request) {
  // TODO: impl
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
    throw UnsupportedPasswordCharactersException(requestId, req.password, [' ']);
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
}

class PasswordException extends RegistrationException {
  String password;

  PasswordException(super.requestId, this.password);
}

class WeakPasswordException extends PasswordException {
  WeakPasswordException(super.requestId, super.password);
}

class PasswordTooShortException extends PasswordException {
  int minLength;

  PasswordTooShortException(super.requestId, super.password, this.minLength);
}

class PasswordTooLongException extends PasswordException {
  int maxLength;

  PasswordTooLongException(super.requestId, super.password, this.maxLength);
}

class UnsupportedPasswordCharactersException extends PasswordException {
  List<String> unsupportedCharacters;

  UnsupportedPasswordCharactersException(super.requestId, super.password, this.unsupportedCharacters);
}

class EmailAlreadyInUseException extends RegistrationException {
  String email;

  EmailAlreadyInUseException(super.requestId, this.email);
}

class InvalidEmailException extends RegistrationException {
  String email;

  InvalidEmailException(super.requestId, this.email);
}

class LoginException extends UserManagementException {
  LoginException(super.requestId);
}

class InvalidCredentialsException extends LoginException {
  String email;

  InvalidCredentialsException(super.requestId, this.email);
}

// imagine this exception comes from DB library, not from our code
class UniqueConstraintViolationDBException implements Exception {}
