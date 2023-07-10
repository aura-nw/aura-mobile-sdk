import 'package:aura_wallet/src/domain/entities/aura_token_market.dart';

abstract class MarketRepository{

  Future<AuraTokenMarket> getTokenInfo({required String id});
}