import 'package:aura_wallet/app_configs/aura_wallet_config.dart';
import 'package:aura_wallet/app_configs/di.dart';
import 'package:aura_wallet/src/core/exception/aura_exception_wrapper.dart';
import 'package:aura_wallet/src/core/utils/dart_core_extension.dart';
import 'package:aura_wallet/src/domain/entities/aura_block.dart';
import 'package:aura_wallet/src/domain/entities/aura_transaction.dart';
import 'package:aura_wallet/src/domain/entities/aura_wallet_balance.dart';
import 'package:aura_wallet/src/domain/entities/requests/get_block_parameter.dart';
import 'package:aura_wallet/src/domain/entities/requests/get_transaction_parameter.dart';
import 'package:aura_wallet/src/domain/entities/requests/get_wallet_balance_parameter.dart';
import 'package:aura_wallet/src/domain/repository/horo_scope_repository.dart';

class HoroScopeUseCase {
  final HoroScopeRepository _repository;

  const HoroScopeUseCase(this._repository);

  Future<List<AuraBlockData>> getBlocks({
    int pageLimit = 5,
  }) async {
    final AuraWalletConfig config = getIt.get<AuraWalletConfig>();

    if (config.environment == Environment.dev) return [];

    final GetBlockParameter param = GetBlockParameter(
      chainId: config.configs!.chainId,
      pageLimit: pageLimit,
    );

    return AuraWalletExceptionWrapper.instance.call(
      onRequest: _repository.getBlocks(
        queries: param.toMap(),
      ),
    );
  }

  Future<List<AuraTransaction>> getTransactions({
    int pageLimit = 5,
    required String address,
  }) async {
    final AuraWalletConfig config = getIt.get<AuraWalletConfig>();

    if (config.environment == Environment.dev) return [];

    final GetTransactionParameter param = GetTransactionParameter(
      chainId: config.configs!.chainId,
      pageLimit: pageLimit,
      address: address,
    );

    return AuraWalletExceptionWrapper.instance.call(
      onRequest: _repository.getTransactions(
        queries: param.toMap(),
      ),
    );
  }

  Future<AuraWalletBalance> getBalance(String address) async {
    final AuraWalletConfig config = getIt.get<AuraWalletConfig>();

    final GetWalletBalanceParameter param = GetWalletBalanceParameter(
        chainId: config.configs!.chainId, address: address);

    try {
      final data = await AuraWalletExceptionWrapper.instance.call(
        onRequest: _repository.getBalances(
          queries: param.toMap(),
        ),
      );

      final balance = data.balances
          .firstWhereOrNull((e) => e.deNom == config.configs!.deNom);

      return balance ??
          AuraWalletBalance(
            id: '',
            amount: '0',
            deNom: config.configs!.deNom,
          );
    } catch (e) {
      return AuraWalletBalance(
        id: '',
        amount: '0',
        deNom: config.configs!.deNom,
      );
    }
  }
}
