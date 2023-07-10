import 'package:aura_sdk/aura_sdk.dart';
import 'package:aura_sdk/src/cores/errors/sdk_error.dart';

extension AuraInternalErrorMapper on AuraInternalError {
  AuraSDKError get toError {
    return AuraSDKError(errorCode, message);
  }
}

extension AuraExternalErrorMapper on AuraExternalError {
  AuraSDKError get toError {
    return AuraSDKError(errorCode, message);
  }
}
