import 'package:aura_sdk/aura_sdk.dart';
import 'package:aura_wallet_example/src/presentation/screens/splash/splash_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(const SplashScreenState());

  Future<void> starting() async {
    emit(
      state.copyWith(
        status: SplashScreenStatus.starting,
      ),
    );
    try {
      final wallet = await AuraSDK.instance.inAppWallet.loadCurrentWallet();

      if (wallet == null) {
        emit(
          state.copyWith(
            status: SplashScreenStatus.loadWalletNull,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: SplashScreenStatus.loadWalletSuccess,
            auraWallet: wallet,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: SplashScreenStatus.loadWalletNull,
        ),
      );
    }
  }
}
