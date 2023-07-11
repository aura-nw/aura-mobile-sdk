import 'package:aura_wallet_example/src/domain/entities/aura_block.dart';
import 'package:aura_wallet_example/src/domain/entities/aura_transaction.dart';
import 'package:aura_wallet_example/src/domain/entities/aura_wallet_balance.dart';

abstract class HoroScopeRepository {
  Future<List<AuraBlockData>> getBlocks({
    required Map<String, dynamic> queries,
  });

  Future<List<AuraTransaction>> getTransactions({
    required Map<String, dynamic> queries,
  });

  Future<AuraWalletBalanceData> getBalances({
    required Map<String, dynamic> queries,
  });
}
