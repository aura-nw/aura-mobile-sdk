class AuraTokenMarket {
  final String coinId;
  final double currentPrice;
  final int maxSupply;
  final double totalVolume;
  final int marketCap;
  final String timeStamp;
  final double priceChangePercentage24h;

  const AuraTokenMarket({
    required this.coinId,
    required this.totalVolume,
    required this.maxSupply,
    required this.marketCap,
    required this.currentPrice,
    required this.priceChangePercentage24h,
    required this.timeStamp,
  });
}
