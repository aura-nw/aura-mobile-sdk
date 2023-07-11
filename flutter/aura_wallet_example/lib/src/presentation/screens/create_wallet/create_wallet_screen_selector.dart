import 'package:aura_sdk/aura_sdk.dart';
import 'package:flutter/material.dart';

import 'create_wallet_screen_bloc.dart';
import 'create_wallet_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateWalletScreenStatusSelector extends BlocSelector<
    CreateWalletScreenBloc, CreateWalletScreenState, CreateWalletScreenStatus> {
  CreateWalletScreenStatusSelector({
    super.key,
    required Widget Function(CreateWalletScreenStatus) builder,
  }) : super(
          builder: (_, status) => builder(status),
          selector: (state) => state.status,
        );
}

class CreateWalletScreenWalletSelector extends BlocSelector<
    CreateWalletScreenBloc, CreateWalletScreenState, AuraFullInfoWallet?> {
  CreateWalletScreenWalletSelector({
    super.key,
    required Widget Function(AuraFullInfoWallet?) builder,
  }) : super(
          builder: (_, wallet) => builder(wallet),
          selector: (state) => state.auraFullInfoWallet,
        );
}
