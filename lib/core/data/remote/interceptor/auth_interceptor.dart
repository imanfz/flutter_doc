import 'package:dio/dio.dart';
import 'package:flutter_doc/core/data/local/secure_preferences.dart';
import 'package:flutter_doc/core/utilities/common/logger.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['requires-token'] == true) {
      /// Get local cahce/secure shared preferences instance
      final prefs = await SecurePreferences.geInstance();

      /// Get token from local cache
      final token = await prefs.getString('token', isEncrypted: true);
      logDebug('Token: $token');

      /// Added token to request headers
      if (token?.isNotEmpty ?? false) {
        options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
      }

      // remove unused api headers
      options.headers.remove('requires-token');
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
    if (err.response?.statusCode == 401) {
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
