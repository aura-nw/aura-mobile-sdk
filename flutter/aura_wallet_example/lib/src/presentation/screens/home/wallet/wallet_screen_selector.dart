import 'package:aura_wallet_example/src/domain/entities/aura_block.dart';
import 'package:aura_wallet_example/src/domain/entities/aura_token_market.dart';
import 'package:aura_wallet_example/src/domain/entities/aura_transaction.dart';
import 'package:aura_wallet_example/src/domain/entities/aura_wallet_balance.dart';

import 'wallet_screen_bloc.dart';
import 'wallet_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class WalletScreenStatusSelector extends BlocSelector<WalletScreenBloc,
    WalletScreenState, WalletScreenStatus> {
  WalletScreenStatusSelector({
    super.key,
    required Widget Function(WalletScreenStatus) builder,
  }) : super(
          builder: (_, status) => builder(status),
          selector: (state) => state.status,
        );
}

class WalletScreenTokenInfoSelector extends BlocSelector<WalletScreenBloc,
    WalletScreenState, AuraTokenMarket?> {
  WalletScreenTokenInfoSelector({
    super.key,
    required Widget Function(AuraTokenMarket?) builder,
  }) : super(
          builder: (_, token) => builder(token),
          selector: (state) => state.token,
        );
}

class WalletScreenBalanceSelector extends BlocSelector<WalletScreenBloc,
    WalletScreenState, AuraWalletBalance> {
  WalletScreenBalanceSelector({
    super.key,
    required Widget Function(AuraWalletBalance) builder,
  }) : super(
          builder: (_, balance) => builder(balance),
          selector: (state) => state.walletBalance,
        );
}

class WalletScreenTransactionsSelector extends BlocSelector<WalletScreenBloc,
    WalletScreenState, List<AuraTransaction>> {
  WalletScreenTransactionsSelector({
    super.key,
    required Widget Function(List<AuraTransaction>) builder,
  }) : super(
          builder: (_, transactions) => builder(transactions),
          selector: (state) => state.transactions,
        );
}

class WalletScreenBlocksSelector extends BlocSelector<WalletScreenBloc,
    WalletScreenState, List<AuraBlockData>> {
  WalletScreenBlocksSelector({
    super.key,
    required Widget Function(List<AuraBlockData>) builder,
  }) : super(
          builder: (_, blocks) => builder(blocks),
          selector: (state) => state.blocks,
        );
}
