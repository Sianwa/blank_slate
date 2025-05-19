import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import '../../utils/service_locator.dart';

class AuthInterceptor extends Interceptor {
  String token = "";
  late SharedPreferences pref;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    getSavedToken().then((value) {
      if (_requiresAuth(options)) {
        //add jwt to header
        if (token.isNotEmpty) {
          options.headers["authorization"] = "Bearer $token";
        }
      }
    });
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      final errorMsg = err.response!.data.toString();
      if (errorMsg.contains("cannot be trusted")) {
        //TODO: navigate to login screen. SESSION EXPIRED
      }
      else if (err.response!.statusCode == 403) {
        //TODO: show msg dialog that session has expired, navigate to login screen. SESSION EXPIRED
      }
      else if (err.response!.statusCode == 503) {
        //TODO: show msg dialog that service is unavailable, navigate to login screen. SESSION EXPIRED
      }
    }
    return super.onError(err, handler);
  }

  Future<void> getSavedToken() async {
    pref = await SharedPreferences.getInstance();
    var savedToken = pref.getString("authToken"); //<-------------------or use string name used to identify your JWT in the const file

    if (savedToken != null) {
      token = savedToken;
    }
  }

  Future<void> deleteSavedToken() async {
    pref = await SharedPreferences.getInstance();
    pref.remove("authToken");//<-------------------or use string name used to identify your JWT in the const file
  }

  bool _requiresAuth(RequestOptions options) {
    //endpoints that don't require authentication
    final noAuthRequiredEndpoints = [
     //TODO: ADD Route names that don't require authentication
    ];

    // Check if the current request's path matches any of the paths in the list
    return !noAuthRequiredEndpoints.contains(options.path);
  }
}
