class AppExceptions implements Exception {
  final String? _message;
  final String? _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class InternetException extends AppExceptions {
  InternetException([String? message])
    : super(message, 'No Internet');
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message])
    : super(message, 'Request Timeout');
}

class ServerExceptions extends AppExceptions {
  ServerExceptions([String? message])
    : super(message, 'Internal Server Error');
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException([String? message])
    : super(message, 'Invalid URL');
}

class UserNotFoundException extends AppExceptions {
  UserNotFoundException([String? message])
    : super(message, 'User Not Found');
}
