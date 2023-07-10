import 'package:aura_wallet/src/data/dto/aura_token_market_dto.dart';
import 'package:aura_wallet/src/data/resource/remote/market_api_service.dart';
import 'package:aura_wallet/src/domain/entities/aura_token_market.dart';
import 'package:aura_wallet/src/domain/repository/market_repository.dart';
import 'package:base_response/base_response.dart';

class MarketRepositoryIml implements MarketRepository{
  final MarketApiService _service;

  const MarketRepositoryIml(this._service);

  @override
  Future<AuraTokenMarket> getTokenInfo({required String id}) async{
    final AuraBaseResponse response = await _service.getTokenMarket(id);

    return AuraTokenMarketDto.fromJson(response.data).toEntities;
  }

}