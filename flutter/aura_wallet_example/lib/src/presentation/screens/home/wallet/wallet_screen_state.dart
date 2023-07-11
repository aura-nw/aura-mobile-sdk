import 'package:aura_wallet_example/src/domain/entities/aura_block.dart';
import 'package:aura_wallet_example/src/domain/entities/aura_token_market.dart';
import 'package:aura_wallet_example/src/domain/entities/aura_transaction.dart';
import 'package:aura_wallet_example/src/domain/entities/aura_wallet_balance.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_screen_state.freezed.dart';

enum WalletScreenStatus {
  loading,
  loaded,
  error,
}

@freezed
class WalletScreenState with _$WalletScreenState {
  const factory WalletScreenState({
    @Default(WalletScreenStatus.loaded) WalletScreenStatus status,
    AuraTokenMarket? token,
    @Default([]) List<AuraTransaction> transactions,
    @Default([]) List<AuraBlockData> blocks,
    @Default(
      AuraWalletBalance(
        id: '0',
        amount: '0',
        deNom: 'Aura',
      ),
    )
    AuraWalletBalance walletBalance,
  }) = _WalletScreenState;
}
