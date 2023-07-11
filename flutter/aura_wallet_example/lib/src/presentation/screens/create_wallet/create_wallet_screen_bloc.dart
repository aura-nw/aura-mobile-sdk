import 'package:aura_sdk/aura_sdk.dart' hide Duration;

import 'create_wallet_screen_event.dart';
import 'create_wallet_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateWalletScreenBloc
    extends Bloc<CreateWalletScreenEvent, CreateWalletScreenState> {
  CreateWalletScreenBloc() : super(const CreateWalletScreenState()) {
    on(_onStart);
  }

  void _onStart(CreateWalletScreenStartEvent event,
      Emitter<CreateWalletScreenState> emit) async {
    emit(state.copyWith(status: CreateWalletScreenStatus.loading));

    await Future.delayed(const Duration(milliseconds: 300));

    final auraWallet =
        await AuraSDK.instance.inAppWallet.createRandomHDWallet();

    emit(
      state.copyWith(
        status: CreateWalletScreenStatus.loaded,
        auraFullInfoWallet: auraWallet,
      ),
    );
  }
}
