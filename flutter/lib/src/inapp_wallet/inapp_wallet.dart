import 'package:alan/alan.dart';
import 'package:alan/proto/cosmos/bank/v1beta1/tx.pb.dart';

import 'src/aura_transaction_info.dart';
import 'inapp_wallet_impl.dart';
import 'src/wallet_info.dart';
export 'src/wallet_info.dart';

///
/// An in-app wallet that allows you to perform various operations related to the blockchain, such as creating a wallet, restoring a wallet, checking the balance, sending transactions, and checking transaction history.
///
/// {@category InAppWallet}
abstract class InAppWallet {
  ///
  /// Create new random HDWallet
  ///
  ///
  /// {@category InAppWallet}
  Future<WalletInfo> createRandomHDWallet();

  ///
  /// Restore HDWallet from mnemonic
  ///
  Future<WalletInfo> restoreHDWallet({required String mnemonic});

  ///
  /// Create a new transaction and sign it
  ///
  Future<Tx> makeTransaction({
    required Wallet wallet,
    required String toAddress,
    required String amount,
    required String fee,
  });

  ///
  /// Send the transaction to Aura network
  ///
  Future<bool> submitTransaction({required Tx signedTransaction});

  ///
  /// Check balance value of an address
  ///
  Future<String> checkWalletBalance({required String address});

  ///
  /// Get List Transaction of an address
  ///
  Future<List<AuraTransaction>> checkWalletHistory({required String address});

  ///
  /// Return response data corresponding query
  ///
  Future<String> makeInteractiveQuerySmartContract({
    required String contractAddress,
    required Map<String, dynamic> query,
  });

  ///
  /// Return TxHash code corresponding execute message
  ///
  Future<String> makeInteractivePutSmartContract({
    required String contractAddress,
    required String sender,
    required Map<String, dynamic> message,
  });

  ///
  /// Return TxHash code corresponding execute message
  ///
  Future<String> makeInteractiveWriteSmartContract({
    required String contractAddress,
    required Wallet wallet,
    required Map<String, dynamic> executeMessage,
    List<int>? funds,
    int? fee,
  });
}
