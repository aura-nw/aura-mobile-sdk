class AuraWalletInfo {
  final String name;
  final String algo;
  final String pubKey;
  final String address;
  final String be32Address;
  final bool isNanoLedger;

  const AuraWalletInfo({
    required this.name,
    required this.address,
    required this.algo,
    required this.be32Address,
    required this.isNanoLedger,
    required this.pubKey,
  });

  factory AuraWalletInfo.fromJson(Map<String, dynamic> json) {
    return AuraWalletInfo(
      name: json['name'],
      address: json['address'],
      algo: json['algo'],
      be32Address: json['bech32Address'],
      isNanoLedger: json['isNanoLedger'],
      pubKey: json['pubKey'],
    );
  }
}

class AuraWalletInfoData {
  final String idConnection;
  final AuraWalletInfo data;

  const AuraWalletInfoData({
    required this.data,
    required this.idConnection,
  });
}
