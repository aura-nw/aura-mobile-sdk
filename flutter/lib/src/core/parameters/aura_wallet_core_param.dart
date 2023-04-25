abstract class AuraWalletCoreParam {
  final String method;

  AuraWalletCoreParam({
    required this.method,
  });

  Map<String, dynamic> toJson() {
    return {
      'method': method,
    };
  }
}
