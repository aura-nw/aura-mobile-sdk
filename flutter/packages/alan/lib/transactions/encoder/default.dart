import 'dart:typed_data';

import 'package:alan/alan.dart';

/// Returns a default protobuf TxEncoder.
TxEncoder defaultEncoder() {
  return (Tx tx) {
    // Check the body
    if (!tx.hasBody()) {
      throw Exception('Empty body');
    }
    final Uint8List bodyBz = tx.body.writeToBuffer();

    // Check the auth info
    if (!tx.hasAuthInfo()) {
      throw Exception('Empty auth info');
    }
    final Uint8List authInfoBz = tx.authInfo.writeToBuffer();

    // Create the raw Tx
    final txRaw = TxRaw.create()
      ..authInfoBytes = authInfoBz
      ..bodyBytes = bodyBz;
    txRaw.signatures.addAll(tx.signatures);

    return txRaw.writeToBuffer();
  };
}
