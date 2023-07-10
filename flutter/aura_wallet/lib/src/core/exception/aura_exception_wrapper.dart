import 'dart:io';

import 'package:aura_wallet/src/core/exception/aura_exception.dart';
import 'package:base_exception_wrapper/base_exception_wrapper.dart';
import 'package:base_response/base_response.dart';
import 'package:dio/dio.dart';

class AuraWalletExceptionWrapper extends BaseExceptionWrapperHelper {
  static AuraWalletExceptionWrapper? _exceptionWrapper;

  static AuraWalletExceptionWrapper _instance() {
    _exceptionWrapper ??= AuraWalletExceptionWrapper._();

    return _exceptionWrapper!;
  }

  static AuraWalletExceptionWrapper get instance => _instance();

  AuraWalletExceptionWrapper._();

  @override
  AppError handleError(Object e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.sendTimeout:
          return AppError(
            code: 50,
            message: e.message,
          );
        case DioExceptionType.receiveTimeout:
          return AppError(code: 51, message: e.message);

        case DioExceptionType.unknown:
          return _convertOtherExceptionOrElse(e);
        case DioExceptionType.connectionTimeout:
          return AppError(
            code: 52,
            message: e.message,
          );
        case DioExceptionType.badResponse:
          final errorCode = e.response?.statusCode;

          return AppError(
            code: errorCode!,
            message: e.message,
          );
        case DioExceptionType.cancel:
          return AppError(code: 53, message: e.message);
        case DioExceptionType.badCertificate:
          return AppError(code: 54, message: e.message);
        case DioExceptionType.connectionError:
          return AppError(code: 55, message: e.message);
        default:
          return const AppError(
            code: 999,
          );
      }
    }

    return const AppError(
      code: 999,
    );
  }

  AppError _convertOtherExceptionOrElse(Object ex) {
    if (ex is DioException && ex.error is FormatException) {
      return AppError(code: 55, message: ex.message);
    }
    if (ex is FormatException) {
      return AppError(
        code: 55,
        message: ex.message,
      );
    }
    if (ex is DioException && ex.error is SocketException) {
      return AppError(
        code: 56,
        message: (ex.error as SocketException).message,
      );
    }

    if (ex is SocketException) {
      return AppError(
        code: 56,
        message: ex.message,
      );
    }

    if (ex is DioException &&
        ex.error
            .toString()
            .toLowerCase()
            .contains('is not a subtype of'.toLowerCase())) {
      return AppError(
        code: 57,
        message: ex.message,
      );
    }

    if (ex
        .toString()
        .toLowerCase()
        .contains('is not a subtype of'.toLowerCase())) {
      return AppError(
        code: 57,
        message: ex.toString(),
      );
    }
    return const AppError(
      code: 999,
    );
  }

  @override
  AuraWalletException? errorMapperHandler(AppError error) {
    return error.toAuraWalletException;
  }
}
