import 'package:aura_sdk/aura_sdk.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_wallet_screen_state.freezed.dart';

enum CreateWalletScreenStatus {
  loading,
  loaded,
}

@freezed
class CreateWalletScreenState with _$CreateWalletScreenState {
  const factory CreateWalletScreenState({
    @Default(CreateWalletScreenStatus.loading) CreateWalletScreenStatus status,
    AuraFullInfoWallet ?auraFullInfoWallet,
  }) = _CreateWalletScreenState;
}
