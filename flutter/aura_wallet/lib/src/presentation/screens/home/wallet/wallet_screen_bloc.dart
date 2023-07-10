import 'package:aura_wallet/src/domain/entities/aura_block.dart';
import 'package:aura_wallet/src/domain/entities/aura_token_market.dart';
import 'package:aura_wallet/src/domain/entities/aura_transaction.dart';
import 'package:aura_wallet/src/domain/entities/aura_wallet_balance.dart';
import 'package:aura_wallet/src/domain/use_case/horo_scope_use_case.dart';
import 'package:aura_wallet/src/domain/use_case/market_use_case.dart';
import 'wallet_screen_event.dart';
import 'wallet_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletScreenBloc extends Bloc<WalletScreenEvent, WalletScreenState> {
  final MarketUseCase _marketUseCase;
  final HoroScopeUseCase _horoScopeUseCase;

  WalletScreenBloc(this._horoScopeUseCase, this._marketUseCase)
      : super(
          const WalletScreenState(),
        ) {
    on(_onStarting);
    on(_onRefreshTransaction);
    on(_onRefreshBlock);
    on(_onRefreshBalance);
  }

  Future<AuraTokenMarket> _getTokenInfo() async {
    return await _marketUseCase.getTokenInfo();
  }

  Future<AuraWalletBalance> _getBalance(String address) async {
    return await _horoScopeUseCase.getBalance(address);
  }

  Future<List<AuraBlockData>> _getBlocks() async {
    return await _horoScopeUseCase.getBlocks();
  }

  Future<List<AuraTransaction>> _getTransactions({
    required String address,
  }) async {
    return await _horoScopeUseCase.getTransactions(
      address: address,
    );
  }

  void _onStarting(
      WalletScreenStartingEvent event, Emitter<WalletScreenState> emit) async {
    emit(state.copyWith(
      status: WalletScreenStatus.loading,
    ));

    try {
      print("#1 ");
      final tokenInfo = await _getTokenInfo();
      print("#2 ");
      final balance = await _getBalance(event.wallet.wallet.bech32Address);
      print("#3 ");
      final transactions = await _getTransactions(
        address: event.wallet.wallet.bech32Address,
      );
      print("#4 ");
      // final blocks = await _getBlocks();
      emit(
        state.copyWith(
          status: WalletScreenStatus.loaded,
          token: tokenInfo,
          walletBalance: balance,
          transactions: transactions,
          // blocks: blocks,
        ),
      );
      print("#5 ");
    } catch (e) {
      print(e.toString());
      emit(
        state.copyWith(
          status: WalletScreenStatus.error,
        ),
      );
    }
  }

  void _onRefreshTransaction(WalletScreenRefreshTransactionEvent event,
      Emitter<WalletScreenState> emit) async {
    try {
      final transactions = await _getTransactions(
        address: event.address,
      );

      emit(
        state.copyWith(
          transactions: transactions,
        ),
      );
    } catch (e) {
      ///don't show error for user
    }
  }

  void _onRefreshBlock(WalletScreenRefreshBlockEvent event,
      Emitter<WalletScreenState> emit) async {
    try {
      final blocks = await _getBlocks();

      emit(
        state.copyWith(
          blocks: blocks,
        ),
      );
    } catch (e) {
      ///don't show error for user
    }
  }

  void _onRefreshBalance(WalletScreenRefreshBalanceEvent event,
      Emitter<WalletScreenState> emit) async {
    try {
      final balance = await _getBalance(event.wallet.wallet.bech32Address);

      emit(
        state.copyWith(
          walletBalance: balance,
        ),
      );
    } catch (e) {
      ///don't show error for user
    }
  }
}
