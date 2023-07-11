import 'package:aura_wallet_example/src/data/dto/aura_block_dto.dart';
import 'package:aura_wallet_example/src/data/dto/aura_transaction_dto.dart';
import 'package:aura_wallet_example/src/data/dto/aura_wallet_balance_dto.dart';
import 'package:aura_wallet_example/src/data/resource/remote/horo_scope_api_service.dart';
import 'package:aura_wallet_example/src/domain/entities/aura_block.dart';
import 'package:aura_wallet_example/src/domain/entities/aura_transaction.dart';
import 'package:aura_wallet_example/src/domain/entities/aura_wallet_balance.dart';
import 'package:aura_wallet_example/src/domain/repository/horo_scope_repository.dart';
import 'package:base_response/base_response.dart';

class HoroScopeRepositoryIml implements HoroScopeRepository {
  final HoroScopeApiService _service;

  const HoroScopeRepositoryIml(this._service);

  @override
  Future<List<AuraBlockData>> getBlocks(
      {required Map<String, dynamic> queries}) async {
    final HoroScopeBaseResponse response = await _service.getBlocks(queries);

    final data = HoroScopeBaseResponse.handleResponse(response);

    final List<AuraBlockDataDto> blocks = List.empty(growable: true);
    for (final json in data['blocks']) {
      final AuraBlockDataDto block = AuraBlockDataDto.fromJson(json);

      blocks.add(block);
    }

    return blocks.map((e) => e.toEntities).toList();
  }

  @override
  Future<List<AuraTransaction>> getTransactions(
      {required Map<String, dynamic> queries}) async {
    final HoroScopeBaseResponse response =
        await _service.getTransactions(queries);

    final data = HoroScopeBaseResponse.handleResponse(response);

    final List<AuraTransactionDto> transactions = List.empty(growable: true);
    for (final json in data['transactions']) {
      final AuraTransactionDto transaction = AuraTransactionDto.fromJson(json);

      transactions.add(transaction);
    }

    return transactions.map((e) => e.toEntities).toList();
  }

  @override
  Future<AuraWalletBalanceData> getBalances(
      {required Map<String, dynamic> queries}) async {
    final HoroScopeBaseResponse response = await _service.getBalances(queries);

    final data = HoroScopeBaseResponse.handleResponse(response);

    final AuraWalletBalanceDataDto balance =
        AuraWalletBalanceDataDto.fromJson(data);

    return balance.toEntities;
  }
}
