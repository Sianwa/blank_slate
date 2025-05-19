import 'dart:typed_data';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../models/responseModels/GenericResponseModel.dart';

part 'api_client.g.dart';

@RestApi()
abstract class APIClient {
  factory APIClient(Dio dio) = _APIClient;

  /// TODO: ADD YOUR API's HERE
  /// For example:
  @POST("/auth/resend_otp")
  Future<GenericResponseModel> resendOTP(@Body() Map<String, dynamic> body);


  /// to generate the implementation of this endpoints
  /// run this method on any change to this class to generate the auto generated implementation
  /// terminal command: dart run build_runner build --delete-conflicting-outputs
}
