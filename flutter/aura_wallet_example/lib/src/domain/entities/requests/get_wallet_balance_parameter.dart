class GetWalletBalanceParameter {
  final String address;
  final String chainId;

  const GetWalletBalanceParameter(
      {required this.chainId, required this.address});

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'chainId': chainId,
    };
  }
}
