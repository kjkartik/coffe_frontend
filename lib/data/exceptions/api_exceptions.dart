class ApiException implements Exception {
  // ignore: prefer_typing_uninitialized_variables
  final _prefix;

  // ignore: prefer_typing_uninitialized_variables
  final _message;

  ApiException([this._prefix, this._message]);

  @override
  String toString() {
    return "$_prefix $_message";
  }
}

class ErrorInCommunication extends ApiException {
  ErrorInCommunication([String? message])
      : super(message, "Error While Communication with Server");
}

class UserNotFound extends ApiException {
  UserNotFound([String? message]) : super(message, "User Not Found");
}

class BadRequest extends ApiException{
  BadRequest([String? message]): super(message,"Bad Request");
}

class UnauthorisedException extends ApiException{
  UnauthorisedException([String? message]):super(message,"UnAuthorised Request");
}