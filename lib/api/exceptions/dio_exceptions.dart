import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioExceptions implements Exception {
  late String errorMessage;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      //DioExceptionType
      case DioExceptionType.connectionTimeout:
        errorMessage = "Connection timed out.";
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "Request send timed out.";
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "Receiving timed out.";
        break;
      case DioExceptionType.unknown:
        errorMessage = _handleStatusCode(dioError.response);
        break;
      case DioExceptionType.cancel:
        errorMessage = "Request to the server was cancelled.";
        break;
      case DioExceptionType.badResponse:
        final responseData = dioError.response!.data;
        if (responseData is Map<String, dynamic>) {
          errorMessage =
              responseData["message"] ?? _handleStatusCode(dioError.response);
        } else {
          errorMessage = _handleStatusCode(dioError.response);
        }
        break;
      case DioExceptionType.connectionError:
        if (dioError.error.toString().contains('SocketException')) {
          errorMessage = 'No Internet Connection';
          break;
        }
        errorMessage = 'Unexpected error occurred.';
        break;
      default:
        errorMessage = 'Oops! Something went wrong';
        break;
    }
  }

  String _handleStatusCode(Response? response) {
    switch (response?.statusCode) {
      case 400:
        return 'Bad Request';
      case 401:
        return response != null
            ? response.data['message']
            : 'Wrong authentication details provided';
      case 403:
        return 'The authenticated user is not authorised to make this request';
      case 405:
        return 'Method not allowed.';
      case 404:
        return response != null
            ? response.data['body']['message']
            : 'Request not found';
      case 415:
        return 'Unsupported media type.';
      case 417:
        return response != null ? response.data['message'] : 'Undefined error.';
      case 429:
        return 'Too many requests.';
      case 500:
        return 'Internal server error.';
      case 503:
        return 'Service Temporarily Unavailable. Please Try again Later.';
      case 504:
        return 'Service Temporarily Unavailable. Please try again Later.';
      default:
        return 'Oops! Something went wrong.';
    }
  }

  @override
  String toString() => errorMessage;
}
