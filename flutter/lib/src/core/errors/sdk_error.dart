class AuraSDKError extends Error {
  final String message;
  final int errorCode;

  AuraSDKError(
    this.errorCode,
    this.message,
  );
  @override
  String toString() {
    return '[AuraSDKError][$errorCode] - $message';
  }
}
