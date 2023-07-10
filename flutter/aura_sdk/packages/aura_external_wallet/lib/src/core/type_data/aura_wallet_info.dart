class AuraExternalWalletInfo {
  final String name;
  final String algo;
  final String pubKey;
  final String address;
  final String be32Address;
  final bool isNanoLedger;

  const AuraExternalWalletInfo({
    required this.name,
    required this.address,
    required this.algo,
    required this.be32Address,
    required this.isNanoLedger,
    required this.pubKey,
  });

  factory AuraExternalWalletInfo.fromJson(Map<String, dynamic> json) {
    return AuraExternalWalletInfo(
      name: json['name'],
      address: json['address'],
      algo: json['algo'],
      be32Address: json['bech32Address'],
      isNanoLedger: json['isNanoLedger'],
      pubKey: json['pubKey'],
    );
  }
}

class AuraConnectWalletInfoResult {
  final String idConnection;
  final AuraExternalWalletInfo data;
  const AuraConnectWalletInfoResult({
    required this.data,
    required this.idConnection,
  });
}
