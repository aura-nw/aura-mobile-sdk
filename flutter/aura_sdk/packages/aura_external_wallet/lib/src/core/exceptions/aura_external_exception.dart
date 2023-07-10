class AuraExternalError extends Error {
  final String message;
  final int errorCode;

  AuraExternalError(
      this.errorCode,
      this.message,
      );
  @override
  String toString() {
    return '[InternalSDKError][$errorCode] - $message';
  }
}
