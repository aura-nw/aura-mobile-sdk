import 'package:aura_sdk/aura_sdk.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_transaction_event.freezed.dart';

@freezed
class SendTransactionEvent with _$SendTransactionEvent {
  const factory SendTransactionEvent.submit({
    required AuraWallet auraWallet,
  }) = SendTransactionSubmitEvent;

  const factory SendTransactionEvent.addressChange({
    required String address,
  }) = SendTransactionOnAddressChangeEvent;

  const factory SendTransactionEvent.amountChange({
    required int amount,
  }) = SendTransactionOnAmountChangeEvent;

  const factory SendTransactionEvent.memoChange({
    required String memo,
  }) = SendTransactionOnMemoChangeEvent;

  const factory SendTransactionEvent.feeChange({
    required int fee,
  }) = SendTransactionOnFeeChangeEvent;
}
