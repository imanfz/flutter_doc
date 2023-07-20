import 'dart:js_interop';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_doc/core/data/local/secure_preferences.dart';
import 'package:flutter_doc/core/utilities/extensions/misc_ext.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    /// Get local cahce/secure shared preferences instance
    final prefs = await SecurePreferences.geInstance();

    /// Get token from local cache
    String? token = await prefs.getString('token', isEncrypted: true);

    if (kDebugMode) {
      logD('Token: $token');
    }

    /// Added token to request headers
    if (!token.isNull) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    /// if you have custom error code or custom response status
    /// you can implement in here

    /// Example
    // if (response.data['success'] == false) {
    //   return handler.reject(
    //     DioException(
    //       requestOptions: RequestOptions(path: response.requestOptions.path),
    //       response: response,
    //       message: response.data['message'],
    //     ),
    //   );
    // }

    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    /// Check if invalid token or session timeout
    if (err.response?.statusCode == 302 || err.response?.statusCode == 401) {
      /// Get local cahce/secure shared preferences instance
      final prefs = await SecurePreferences.geInstance();

      /// clear local cache
      await prefs.clearAll();

      /// force logout or navigate to login page
      // navigatorKey.currentState!.pushNamedAndRemoveUntil(
      //     "/login_page", (Route<dynamic> route) => false);
    }

    return handler.next(err);
  }
}
