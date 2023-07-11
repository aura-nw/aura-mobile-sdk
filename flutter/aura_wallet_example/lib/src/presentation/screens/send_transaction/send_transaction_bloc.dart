import 'send_transaction_event.dart';
import 'send_transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendTransactionBloc
    extends Bloc<SendTransactionEvent, SendTransactionState> {
  SendTransactionBloc()
      : super(
          const SendTransactionState(),
        ) {
    on(_onChangeAmount);
    on(_onChangeReceiveAddress);
    on(_onChangeMemo);
    on(_onChangeFee);
    on(_onSubmitTransaction);
  }

  void _onChangeAmount(SendTransactionOnAmountChangeEvent event,
      Emitter<SendTransactionState> emit) {
    bool isReady = _onChange(event.amount, state.receiveAddress);

    emit(state.copyWith(
      amount: event.amount,
      isReady: isReady,
    ));
  }

  void _onChangeReceiveAddress(SendTransactionOnAddressChangeEvent event,
      Emitter<SendTransactionState> emit) {
    bool isReady = _onChange(state.amount, event.address);
    emit(state.copyWith(
      receiveAddress: event.address,
      isReady: isReady,
    ));
  }

  void _onChangeMemo(SendTransactionOnMemoChangeEvent event,
      Emitter<SendTransactionState> emit) {
    emit(
      state.copyWith(
        memo: event.memo,
      ),
    );
  }

  void _onChangeFee(SendTransactionOnFeeChangeEvent event,
      Emitter<SendTransactionState> emit) {
    emit(state.copyWith(
      fee: event.fee,
    ));
  }

  void _onSubmitTransaction(SendTransactionSubmitEvent event,
      Emitter<SendTransactionState> emit) async {
    if (!state.isReady) return;

    emit(
      state.copyWith(
        status: SendTransactionStatus.starting,
      ),
    );

    try {
      final tx = await event.auraWallet.makeTransaction(
        toAddress: state.receiveAddress,
        amount: state.amount.toString(),
        fee: state.fee.toString(),
        memo: state.memo,
      );

      final result = await event.auraWallet.submitTransaction(
        signedTransaction: tx,
      );

      emit(
        state.copyWith(
          status: result
              ? SendTransactionStatus.success
              : SendTransactionStatus.error,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: e.toString(),
          status: SendTransactionStatus.error,
        ),
      );
    }
  }

  bool _onChange(
    int amount,
    String address,
  ) {
    return amount > 0 && address.isNotEmpty;
  }
}
