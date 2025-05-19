import 'package:blank_slate/api/interceptors/dio_error_interceptor.dart';
import 'package:dio/dio.dart';

import 'controllers/api_client.dart';
import 'interceptors/auth_interceptor.dart';

class Client{
  static late Dio _dio;

  static APIClient init(){
    _dio = Dio(
        BaseOptions(
          baseUrl: "https://www.google.com", //<------------------------------- TODO : ADD URL HERE
          connectTimeout:const Duration(milliseconds: 120000),
          receiveTimeout: const Duration(milliseconds: 120000),
        )
    );

    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(DioErrorInterceptor());

    // Add an interceptor to log requests and responses
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
    ));

    return APIClient(_dio);
  }

}