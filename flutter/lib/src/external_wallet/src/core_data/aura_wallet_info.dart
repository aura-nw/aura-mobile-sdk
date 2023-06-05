class AuraWalletInfoData {
  final String name;
  final String algo;
  final String pubKey;
  final String address;
  final String be32Address;
  final bool isNanoLedger;

  const AuraWalletInfoData({
    required this.name,
    required this.address,
    required this.algo,
    required this.be32Address,
    required this.isNanoLedger,
    required this.pubKey,
  });

  factory AuraWalletInfoData.fromJson(Map<String, dynamic> json) {
    return AuraWalletInfoData(
      name: json['name'],
      address: json['address'],
      algo: json['algo'],
      be32Address: json['bech32Address'],
      isNanoLedger: json['isNanoLedger'],
      pubKey: json['pubKey'],
    );
  }
}

class AuraWalletInfo {
  final String idConnection;
  final AuraWalletInfoData data;
  const AuraWalletInfo({
    required this.data,
    required this.idConnection,
  });
}
