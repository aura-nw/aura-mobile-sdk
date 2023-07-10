class AuraBlockData {
  final String id;
  final String validatorName;
  final String operatorAddress;
  final AuraBlock block;

  const AuraBlockData({
    required this.id,
    required this.block,
    required this.validatorName,
    required this.operatorAddress,
  });
}

class AuraBlock {
  final AuraBlockBody data;
  final AuraBlockHeader header;

  const AuraBlock({
    required this.header,
    required this.data,
  });
}

class AuraBlockHeader {
  final String chainId;
  final int height;
  final String time;

  const AuraBlockHeader({
    required this.chainId,
    required this.height,
    required this.time,
  });
}

class AuraBlockBody {}
