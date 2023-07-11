// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aura_token_market_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuraTokenMarketDto _$AuraTokenMarketDtoFromJson(Map<String, dynamic> json) =>
    AuraTokenMarketDto(
      coinId: json['coinId'] as String,
      totalVolume: (json['total_volume'] as num).toDouble(),
      maxSupply: json['max_supply'] as int,
      marketCap: json['market_cap'] as int,
      currentPrice: (json['current_price'] as num).toDouble(),
      priceChangePercentage24h:
          (json['price_change_percentage_24h'] as num).toDouble(),
      timeStamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$AuraTokenMarketDtoToJson(AuraTokenMarketDto instance) =>
    <String, dynamic>{
      'coinId': instance.coinId,
      'current_price': instance.currentPrice,
      'max_supply': instance.maxSupply,
      'total_volume': instance.totalVolume,
      'market_cap': instance.marketCap,
      'timestamp': instance.timeStamp,
      'price_change_percentage_24h': instance.priceChangePercentage24h,
    };
