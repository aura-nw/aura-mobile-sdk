import 'package:aura_sdk/aura_sdk.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_screen_event.freezed.dart';

@freezed
class WalletScreenEvent with _$WalletScreenEvent {
  const factory WalletScreenEvent.starting(
    AuraWallet wallet,
  ) = WalletScreenStartingEvent;

  const factory WalletScreenEvent.refreshTransaction(String address,) =
      WalletScreenRefreshTransactionEvent;

  const factory WalletScreenEvent.refreshBlock() =
      WalletScreenRefreshBlockEvent;

  const factory WalletScreenEvent.refreshBalance(AuraWallet wallet,) =
      WalletScreenRefreshBalanceEvent;
}
