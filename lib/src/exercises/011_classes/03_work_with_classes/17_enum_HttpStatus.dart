void main() {
  print(HttpStatus.values);
}

enum HttpStatus {
  ok(200, 'OK'),
  notFound(404, 'Not Found');

  final int _statusCode;
  final String _description;

  const HttpStatus(this._statusCode, this._description);

  static HttpStatus? fromStatusCode(int statusCode) {
    for (var value in HttpStatus.values) {
      if (value._statusCode == statusCode) {
        return value;
      }
    }
    return null;
  }

  @override
  String toString() {
    return 'Http status code: $_statusCode, description: $_description}';
  }
}
