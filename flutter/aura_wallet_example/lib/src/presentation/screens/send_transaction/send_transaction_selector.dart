import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'send_transaction_bloc.dart';
import 'send_transaction_state.dart';

class SendTransactionIsReadySubmitSelector
    extends BlocSelector<SendTransactionBloc, SendTransactionState, bool> {
  SendTransactionIsReadySubmitSelector({
    super.key,
    required Widget Function(bool) builder,
  }) : super(
          builder: (_, isReady) => builder(isReady),
          selector: (state) => state.isReady,
        );
}
