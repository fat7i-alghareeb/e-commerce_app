import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDiorError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
            'Connection timed out while contacting the server. Please check your internet connection and try again.');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Request sending timed out. Please try again.');

      case DioExceptionType.receiveTimeout:
        return ServerFailure(
            'Server took too long to respond. Please try again.');

      case DioExceptionType.badCertificate:
        return ServerFailure(
            'There was a security issue with the server certificate. Please contact support.');

      case DioExceptionType.cancel:
        return ServerFailure(
            'Request to server was canceled. Please try again.');

      case DioExceptionType.connectionError:
        return ServerFailure(
            'No internet connection. Please connect to a network and try again.');

      case DioExceptionType.unknown:
        return ServerFailure(
            'Oops! Something went wrong unexpectedly. Please try again later or contact support.');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            e.response!.statusCode!, e.response!.data);
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return ServerFailure('The requested resource was not found.');
    } else if (statusCode == 500) {
      return ServerFailure(
          'Internal server error. Please try again later or contact support.');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else {
      return ServerFailure(
          'An unknown error occurred. Please try again later or contact support.');
    }
  }
}
