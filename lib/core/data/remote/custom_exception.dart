class CustomException implements Exception {
  final String _message;
  final String _prefix;

  CustomException(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException(String message)
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([message]) : super(message, "Unauthorized: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException(String message) : super(message, "Invalid Input: ");
}

class NotFoundException extends CustomException {
  NotFoundException([message]) : super(message, "Not Found: ");
}

class InternalServerErrorException extends CustomException {
  InternalServerErrorException([message]) : super(message, "Internal Server Error: ");
}

class ConflictException extends CustomException {
  ConflictException([message]) : super(message, "Conflict Occured: ");
}

class ForbiddenException extends CustomException {
  ForbiddenException([message]) : super(message, "Forbidden: ");
}