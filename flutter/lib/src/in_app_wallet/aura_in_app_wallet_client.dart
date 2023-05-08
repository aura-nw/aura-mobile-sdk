import 'package:alan/alan.dart';
import 'package:alan/proto/cosmos/bank/v1beta1/export.dart' as bank;
import 'package:alan/proto/cosmos/bank/v1beta1/tx.pb.dart';
import 'package:alan/proto/cosmos/tx/v1beta1/export.dart' as auraTx;
import 'package:aura_mobile_sdk/src/constants/constant.dart';
import 'package:aura_mobile_sdk/src/core/in_app_core_data/in_app_core_data.dart';
import 'package:aura_mobile_sdk/src/core/utils/transaction_helper.dart';
import 'dart:developer' as log;

class AuraInAppWalletClient {
  final LCDInfo lcdInfo;
  final GRPCInfo grpcInfo;

  AuraInAppWalletClient({
    required this.lcdInfo,
    required this.grpcInfo,
  }) {
    networkInfo = NetworkInfo(
      bech32Hrp: bech32Hrp,
      lcdInfo: lcdInfo,
      grpcInfo: grpcInfo,
    );
  }

  late NetworkInfo networkInfo;

  Future<Fee> createFee({required String amount}) async {
    final fee = Fee();
    fee.gasLimit = 200000.toInt64();
    fee.amount.add(
      Coin.create()
        ..amount = amount
        ..denom = deNom,
    );
    return fee;
  }

  Future<AuraInAppWalletInfo> createRandomHDWallet() async {
    List<String> mnemonic2 = Bip39.generateMnemonic(strength: 256);
    final Wallet wallet = Wallet.derive(mnemonic2, networkInfo);
    final AuraInAppWalletInfo walletInfo =
        AuraInAppWalletInfo(wallet, mnemonic2.join(' '));
    return walletInfo;
  }

  Future<MsgSend> createTransaction(
      {required String fromAddress,
      required String toAddress,
      required String amount}) async {
    final MsgSend message = bank.MsgSend.create()
      ..fromAddress = fromAddress
      ..toAddress = toAddress;
    message.amount.add(Coin.create()
      ..denom = deNom
      ..amount = amount);
    return message;
  }

  Future<AuraInAppWalletInfo> restoreHDWallet(
      {required String mnemonic}) async {
    final wallet = Wallet.derive(mnemonic.split(' '), networkInfo);
    final AuraInAppWalletInfo walletInfo =
        AuraInAppWalletInfo(wallet, mnemonic);
    return walletInfo;
  }

  Future<Tx> signTransaction(
      {required Wallet wallet,
      required List<MsgSend> msgSend,
      required Fee fee}) async {
    final signer = TxSigner.fromNetworkInfo(networkInfo);
    final tx = await signer.createAndSign(wallet, msgSend, fee: fee);
    return tx;
  }

  Future<bool> submitTransaction({required Tx signedTransaction}) async {
    final txSender = TxSender.fromNetworkInfo(networkInfo);

    final response = await txSender.broadcastTx(signedTransaction);

    return response.isSuccessful;
  }

  Future<String> checkWalletBalance({required String address}) async {
    final req = bank.QueryBalanceRequest(
      address: address,
      denom: deNom,
    );
    final client = bank.QueryClient(networkInfo.gRPCChannel);

    final response = await client.balance(req);
    response.balance;

    return response.balance.amount;
  }

  Future<bool> checkMnemonic({required String mnemonic}) async {
    return Bip39.validateMnemonic(mnemonic.split(' '));
  }

  Future<List<AuraTransaction>> checkWalletHistory(
      {required String address}) async {
    List<AuraTransaction>? listSender =
        await _getListTransactionByAddress(address, TransactionType.send);
    List<AuraTransaction>? listReceive = await _getListTransactionByAddress(
      address,
      TransactionType.receive,
    );

    List<AuraTransaction> listAllTransaction = [];
    listAllTransaction.addAll(listSender ?? []);
    listAllTransaction.addAll(listReceive ?? []);

    listAllTransaction.sort((a, b) {
      DateTime? aDate = DateTime.tryParse(a.timestamp);
      DateTime? bDate = DateTime.tryParse(b.timestamp);
      if (aDate == null || bDate == null) {
        return 0; // Skip
      }

      return aDate.compareTo(bDate);
    });

    return listAllTransaction;
  }

  Future<List<AuraTransaction>?> _getListTransactionByAddress(
      String address, TransactionType transactionType) async {
    if (transactionType == TransactionType.send) {
      final request = auraTx.GetTxsEventRequest(events: [
        "transfer.sender='$address'",
      ], pagination: PageRequest(offset: 0.toInt64(), limit: 100.toInt64()));
      try {
        final client = auraTx.ServiceClient(networkInfo.gRPCChannel);
        final GetTxsEventResponse response = await client.getTxsEvent(request);

        List<AuraTransaction> listData =
            TransactionHelper.convertToAuraTransaction(
                response.txResponses, transactionType);
        return listData;
      } catch (e,s) {
        log.log('error when send transaction\n${e.toString()}',stackTrace: s);
      }
      return null;
    } else if (transactionType == TransactionType.receive) {
      final request = auraTx.GetTxsEventRequest(
        events: [
          "transfer.recipient='$address'",
        ],
        pagination: PageRequest(
          offset: 0.toInt64(),
          limit: 100.toInt64(),
        ),
      );
      try {
        final client = auraTx.ServiceClient(networkInfo.gRPCChannel);
        final GetTxsEventResponse response = await client.getTxsEvent(request);

        List<AuraTransaction> listData =
            TransactionHelper.convertToAuraTransaction(
                response.txResponses, transactionType);
        return listData;
      } catch (e,s) {
        log.log('error when receive transaction\n${e.toString()}',stackTrace: s);
      }
      return null;
    }

    return null;
  }
}
