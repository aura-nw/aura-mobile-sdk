import 'app_error.dart';

class HoroScopeBaseResponse<T> {
  final int code;
  final T? data;
  final String message;

  const HoroScopeBaseResponse({
    required this.code,
    this.data,
    required this.message,
  });

  factory HoroScopeBaseResponse.fromJson(Map<String, dynamic> json) {
    return HoroScopeBaseResponse(
      code: json['code'],
      data: json['data'],
      message: json['message'],
    );
  }

  static T? handleResponse<T>(HoroScopeBaseResponse<T> response) {
    if (response.code == 200) {
      return response.data;
    }

    throw AppError(
      message: response.message,
      code: response.code,
    );
  }
}

class AuraBaseResponse<T> {
  final T? data;
  final dynamic meta;

  const AuraBaseResponse({
    this.data,
    this.meta,
  });

  factory AuraBaseResponse.fromJson(Map<String, dynamic> json) {
    return AuraBaseResponse(
      data: json['data'],
      meta: json['meta'],
    );
  }
}
