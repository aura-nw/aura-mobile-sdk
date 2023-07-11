import 'package:aura_wallet_example/src/domain/entities/aura_token_market.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aura_token_market_dto.g.dart';

extension AuraTokenMarketMapper on AuraTokenMarketDto {
  AuraTokenMarket get toEntities => AuraTokenMarket(
        coinId: coinId,
        totalVolume: totalVolume,
        maxSupply: maxSupply,
        marketCap: marketCap,
        currentPrice: currentPrice,
        priceChangePercentage24h: priceChangePercentage24h,
        timeStamp: timeStamp,
      );
}

@JsonSerializable()
class AuraTokenMarketDto {
  @JsonKey(name: 'coinId')
  final String coinId;
  @JsonKey(name: 'current_price')
  final double currentPrice;
  @JsonKey(name: 'max_supply')
  final int maxSupply;
  @JsonKey(name: 'total_volume')
  final double totalVolume;
  @JsonKey(name: 'market_cap')
  final int marketCap;
  @JsonKey(name: 'timestamp')
  final String timeStamp;
  @JsonKey(name: 'price_change_percentage_24h')
  final double priceChangePercentage24h;

  const AuraTokenMarketDto({
    required this.coinId,
    required this.totalVolume,
    required this.maxSupply,
    required this.marketCap,
    required this.currentPrice,
    required this.priceChangePercentage24h,
    required this.timeStamp,
  });

  factory AuraTokenMarketDto.fromJson(Map<String, dynamic> json) =>
      _$AuraTokenMarketDtoFromJson(json);
}
