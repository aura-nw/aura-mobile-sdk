import 'package:aura_wallet_example/app_configs/aura_wallet_config.dart';
import 'package:aura_wallet_example/app_configs/di.dart';
import 'package:aura_wallet_example/src/core/exception/aura_exception_wrapper.dart';
import 'package:aura_wallet_example/src/domain/entities/aura_token_market.dart';
import 'package:aura_wallet_example/src/domain/repository/market_repository.dart';

class MarketUseCase {
  final MarketRepository _repository;

  const MarketUseCase(this._repository);

  Future<AuraTokenMarket> getTokenInfo() async {
    final AuraWalletConfig config = getIt.get<AuraWalletConfig>();

    return AuraWalletExceptionWrapper.instance.call(
      onRequest: _repository.getTokenInfo(
        id: config.configs!.coinId,
      ),
    );
  }
}
