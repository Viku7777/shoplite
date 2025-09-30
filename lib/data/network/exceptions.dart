class ApiExceptions implements Exception {
  final title;
  final message;

  ApiExceptions([this.title, this.message]);

  @override
  String toString() {
    return "$message";
  }
}

class FetchDataException extends ApiExceptions {
  FetchDataException([String? title])
    : super(title, "Error During Communication");
}

class NetworkException extends ApiExceptions {
  NetworkException([String? title])
    : super(title, "Please check your internet");
}

class BadRequestException extends ApiExceptions {
  BadRequestException([String? title]) : super(title, "Invalid request");
}

class TimeoutException extends ApiExceptions {
  TimeoutException([String? title]) : super(title, "Timeout");
}

class OtherException extends ApiExceptions {
  OtherException([String? message])
    : super("Something Went Wrong !!!", message);
}
