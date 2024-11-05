// Class to handle custom exeptions
class AppExceptions implements Exception {
  // _message shows the error message that will be given when calling exeptions
  // _prefix is the messages that are written below in specific exeption classes
  final _message;
  final _prefix;
  AppExceptions([this._message, this._prefix]);

  String toString() {
    return '$_prefix: ($_message)';
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message, 'Error During Communication');
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message]) : super(message, 'Url Not Found');
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? message])
      : super(message, 'Unauthorized Request');
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}
