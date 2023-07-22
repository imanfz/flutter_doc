import 'package:dio/dio.dart';
import 'package:flutter_doc/core/utilities/common/logger.dart';
import 'package:flutter_doc/core/utilities/extensions/misc_ext.dart';

class LoggingInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final tag = options.path;
    logInfo(
        "===> ${options.method.toUpperCase()} ${options.baseUrl + options.path}",
        tag: tag);
    if (options.headers.isNotEmpty) {
      logInfo("=== Headers: === \n${options.headers}", tag: tag);
      // options.headers.forEach((k, v) => logInfo('$k: $v', tag: tag));
    }
    if (options.queryParameters.isNotEmpty) {
      logInfo("=== queryParameters: === \n${options.queryParameters}", tag: tag);
      // options.queryParameters.forEach((k, v) => logInfo('$k: $v', tag: tag));
    }
    if (options.data != null) {
      logInfo("=== Body: === \n${encoder.convert(options.data)}", tag: tag);
    }
    if (options.headers.isNotEmpty ||
        options.queryParameters.isNotEmpty ||
        options.data != null) {
      logInfo("===> END ${options.method.toUpperCase()}", tag: tag);
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final tag = response.requestOptions.path;
    if (!response.headers.isEmpty) {
      logInfo("=== Headers: === \n${response.headers}", tag: tag);
      // response.headers.forEach((k, v) => logInfo('$k: $v', tag: tag));
    }
    if (response.statusCode != null) {
      logInfo("=== Status Code: ${response.statusCode} ===", tag: tag);
    }
    if (response.statusMessage != null) {
      logInfo("=== Status Message: ${response.statusMessage} ===", tag: tag);
    }
    if (response.data != "") {
      logInfo("=== Response: === \n${encoder.convert(response.data)}",
          tag: tag);
    }
    logInfo("<=== END HTTP", tag: tag);

    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final tag = err.requestOptions.path;
    if (err.message != null) {
      logError("<=== ERROR: ${err.message}", tag: tag);
    }
    logError(
        "${err.response != null ? "=== Response: === \n" + encoder.convert(err.response?.data) : 'Unknown Error'}",
        tag: tag);
    logError("<=== End ERROR", tag: tag);

    return handler.next(err);
  }
}
