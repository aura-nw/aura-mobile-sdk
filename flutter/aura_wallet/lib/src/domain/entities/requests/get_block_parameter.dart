class GetBlockParameter {
  final String chainId;
  final int pageLimit;

  const GetBlockParameter({
    required this.chainId,
    this.pageLimit = 10,
  });

  Map<String, dynamic> toMap() {
    return {
      'chainid': chainId,
      'pageLimit': pageLimit,
    };
  }
}
