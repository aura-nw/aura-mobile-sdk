import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_transaction_state.freezed.dart';

enum SendTransactionStatus {
  none,
  starting,
  success,
  error,
}

@freezed
class SendTransactionState with _$SendTransactionState {
  const factory SendTransactionState({
    @Default(SendTransactionStatus.none) SendTransactionStatus status,
    String? error,
    @Default(false) bool isReady,
    @Default(0) int amount,
    @Default('') String receiveAddress,
    @Default('') String memo,
    @Default(100) int fee,
  }) = _SendTransactionState;
}
