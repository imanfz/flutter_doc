import 'package:dio/dio.dart';
import 'package:flutter_doc/core/data/remote/custom_exception.dart';

class ApiService {
  _handleError(dynamic err) {
    if (err is DioException) {
      if (err.type == DioExceptionType.badResponse) {
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.message ?? err.error);
          case 401:
            throw UnauthorizedException(err.message ?? err.error);
          case 403:
            throw ForbiddenException(err.message ?? err.error);
          case 404:
            throw NotFoundException(err.message ?? err.error);
          case 409:
            throw ConflictException(err.message ?? err.error);
          case 500:
            throw InternalServerErrorException(err.message ?? err.error);
          default:
            throw Exception(err);
        }
      } else {
        throw Exception(err);
      }
    } else {
      throw Exception(err);
    }
  }
}
