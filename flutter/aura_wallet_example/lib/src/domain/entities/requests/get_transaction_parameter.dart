class GetTransactionParameter {
  final String chainId;
  final String address;
  final int pageLimit;
  final int offset;

  const GetTransactionParameter({
    required this.address,
    required this.chainId,
    this.pageLimit = 10,
    this.offset = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'chainid': chainId,
      'address': address,
      'pageLimit': pageLimit,
      'offset': offset,
    };
  }
}
