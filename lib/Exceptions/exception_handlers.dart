
import 'dart:async';
import 'dart:io';
//
// class ExceptionHandlers {
//   getExceptionString(error) {
//     if (error is SocketException) {
//       return 'No internet connection.';
//     } else if (error is HttpException) {
//       return 'HTTP error occured.';
//     } else if (error is FormatException) {
//       return 'Invalid data format.';
//     } else if (error is TimeoutException) {
//       return 'Request timedout.';
//     } else if (error is BadRequestException) {
//       print(error.message.toString());
//       return error.message.toString();
//     } else if (error is UnAuthorizedException) {
//       return error.message.toString();
//     } else if (error is NotFoundException) {
//       return error.message.toString();
//     } else if (error is FetchDataException) {
//       return error.message.toString();
//     } else {
//       return 'Unknown error occured.';
//     }
//   }
// }
//
// class AppException implements Exception {
//   final String? message;
//   final String? prefix;
//   final String? url;
//
//   AppException([this.message, this.prefix, this.url]);
// }
//
// class BadRequestException extends AppException {
//   BadRequestException([String? message, String? url])
//       : super(message, 'Bad request', url);
// }
//
// class FetchDataException extends AppException {
//   FetchDataException([String? message, String? url])
//       : super(message, 'Unable to process the request', url);
// }
//
// class ApiNotRespondingException extends AppException {
//   ApiNotRespondingException([String? message, String? url])
//       : super(message, 'Api not responding', url);
// }
//
// class UnAuthorizedException extends AppException {
//   UnAuthorizedException([String? message, String? url])
//       : super(message, 'Unauthorized request', url);
// }
//
// class NotFoundException extends AppException {
//   NotFoundException([String? message, String? url])
//       : super(message, 'Page not found', url);
// }




// ------------------------------------------------------




class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}