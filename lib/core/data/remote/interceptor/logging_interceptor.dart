import 'package:dio/dio.dart';
import 'package:flutter_doc/core/utils/common/logger.dart';
import 'package:flutter_doc/core/utils/extensions/misc_ext.dart';

class LoggingInterceptor extends Interceptor {
  /// `requestHeaders`: Whether to log the request headrers or not,
  /// it should minimize the logging output.
  ///
  /// `responseHeaders`: Whether to log the response headrers or not,
  /// it should minimize the logging output.
  ///
  LoggingInterceptor(
      {bool requestHeaders = true, bool responseHeaders = true})
      : _requestHeaders = requestHeaders,
        _responseHeaders = responseHeaders;

  late final bool _requestHeaders;
  late final bool _responseHeaders;

  void _logHeaders({required Map headers, String? tag}) {
    if (headers.isNotEmpty) {
      logInfo("=== Headers: === \n$headers", tag: tag);
      // options.headers.forEach((k, v) => logInfo('$k: $v', tag: tag));
    }
  }

  void _logRequest(RequestOptions options) {
    final tag = options.path;
    logInfo(
        "===> ${options.method.toUpperCase()} ${options.baseUrl + options.path}",
        tag: tag);

    if (_requestHeaders) {
      _logHeaders(headers: options.headers, tag: tag);
    }

    if (options.queryParameters.isNotEmpty) {
      logInfo("=== queryParameters: === \n${options.queryParameters}",
          tag: tag);
    }
    if (options.data != null) {
      logInfo("=== Request Body: === \n${encoder.convert(options.data)}",
          tag: tag);
    }
    if (options.headers.isNotEmpty ||
        options.queryParameters.isNotEmpty ||
        options.data != null) {
      logInfo("===> END ${options.method.toUpperCase()}", tag: tag);
    }
  }

  void _logResponse(Response response) {
    final tag = response.requestOptions.path;
    if (_responseHeaders) {
      _logHeaders(headers: response.requestOptions.headers, tag: tag);
    }
    if (response.statusCode != null) {
      logInfo("=== Status Code: ${response.statusCode} ===", tag: tag);
    }
    if (response.statusMessage != null) {
      logInfo("=== Status Message: ${response.statusMessage} ===", tag: tag);
    }
    if (response.data != "") {
      logInfo("=== Response Body: === \n${encoder.convert(response.data)}",
          tag: tag);
    }
    logInfo("<=== END HTTP", tag: tag);
  }

  void _logError(DioException err) {
    final tag = err.requestOptions.path;
    if (err.message != null) {
      logError("<=== ERROR: ${err.message}", tag: tag);
    }
    logError(
        "${err.response != null ? "=== Response Body: === \n" + encoder.convert(err.response?.data) : 'Unknown Error'}",
        tag: tag);
    logError("<=== End ERROR", tag: tag);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logRequest(options);
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logResponse(response);
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logError(err);
    return handler.next(err);
  }
}
