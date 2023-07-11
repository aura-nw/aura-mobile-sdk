import 'package:aura_sdk/aura_sdk.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'splash_screen_state.freezed.dart';

enum SplashScreenStatus {
  starting,
  loadWalletSuccess,
  loadWalletNull,
}

@freezed
class SplashScreenState with _$SplashScreenState {
  const factory SplashScreenState({
    @Default(SplashScreenStatus.starting) SplashScreenStatus status,
    AuraWallet ?auraWallet,
  }) = _SplashScreenState;
}
