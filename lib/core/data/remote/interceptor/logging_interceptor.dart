import 'package:dio/dio.dart';
import 'package:flutter_doc/core/utilities/extensions/misc_ext.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logI(
        "--> ${options.method.toUpperCase()} ${options.baseUrl + options.path}");
    if (options.headers.isNotEmpty) {
      logI("Headers:");
      options.headers.forEach((k, v) => print('$k: $v'));
    }
    if (options.queryParameters.isNotEmpty) {
      logI("queryParameters:");
      options.queryParameters.forEach((k, v) => print('$k: $v'));
    }
    if (options.data != null) {
      logI("Body: ${options.data}");
    }
    logI("--> END ${options.method.toUpperCase()}");

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logI(
        "<-- ${err.message} ${err.requestOptions.baseUrl + err.requestOptions.path}");
    logI("${err.response != null ? err.response?.data : 'Unknown Error'}");
    logI("<-- End error");
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logI(
        "<-- ${response.statusCode} ${response.requestOptions.baseUrl + response.requestOptions.path}");
    logI("Headers:");
    response.headers.forEach((k, v) => print('$k: $v'));
    logI("Response: ${response.data}");
    logI("<-- END HTTP");
  }
}
