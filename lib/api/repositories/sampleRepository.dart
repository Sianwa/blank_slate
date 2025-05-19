import 'package:dio/dio.dart';

import '../client.dart';
import '../exceptions/dio_exceptions.dart';
import '../models/responseModels/ErrorResponseModel.dart';
import '../models/responseModels/GenericResponseModel.dart';

class SampleRepository {
  final client = Client.init();

  SampleRepository();

  Future<dynamic> resentOTP(Map<String, dynamic> body) async {
    try {
      var resp = await client.resendOTP(body);
      return genericResponseModelToJson(resp);
    }
    on DioException catch (e) {
      final error = e.error is DioExceptions
          ? e.error.toString()
          : "Something went wrong";
      print("OTP ERROR => $error");
      return ErrorResponseModel("OTP Error", error);
    }
  }
}