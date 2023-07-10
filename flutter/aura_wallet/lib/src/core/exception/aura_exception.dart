import 'package:base_response/base_response.dart';

extension ExceptionMapper on AppError {
  AuraWalletException get toAuraWalletException => AuraWalletException(
        code: code,
        message: message ?? 'Unknown error',
      );
}

class AuraWalletException {
  final int code;
  final String message;

  const AuraWalletException({required this.code, required this.message});

  @override
  String toString() {
    return '[$code] $message';
  }
}
