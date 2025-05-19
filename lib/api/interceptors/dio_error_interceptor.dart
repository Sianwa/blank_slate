import 'package:dio/dio.dart';

import '../exceptions/dio_exceptions.dart';

class DioErrorInterceptor extends Interceptor{

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final formattedError = DioExceptions.fromDioError(err);

    print("Error intercepted: ${formattedError.toString()}");

    return handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: formattedError,
        response: err.response,
        type: err.type,
      ),
    );
  }
}