import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'dart:developer' as auraLog;
import 'dart:typed_data';
import 'package:alan/alan.dart';
import 'package:alan/proto/cosmos/bank/v1beta1/export.dart';
import 'package:alan/proto/cosmos/bank/v1beta1/export.dart' as bank;
import 'package:alan/proto/cosmwasm/wasm/v1/export.dart' as cosMWasm;
import 'package:alan/proto/cosmos/auth/v1beta1/export.dart' as auth;
import 'package:alan/proto/cosmos/tx/v1beta1/export.dart' as auraTx;

import 'dart:ffi';

import 'package:bip39/bip39.dart' as bip39;

import '../core_aura_sdk.dart';
import '../core/errors/sdk_error.dart';
import 'inapp_wallet.dart';
import 'src/aura_transaction_info.dart';
import 'src/inapp_wallet_helper.dart';

class InAppWalletImpl implements InAppWallet {
  final networkInfo = NetworkInfo(
      bech32Hrp: 'aura',
      lcdInfo: LCDInfo(host: 'https://lcd.serenity.aura.network', port: 443),
      grpcInfo:
          GRPCInfo(host: 'http://grpc.serenity.aura.network', port: 9092));

  @override
  Future<WalletInfo> createRandomHDWallet() async {
    List<String> mnemonic2 = Bip39.generateMnemonic(strength: 256);
    final Wallet wallet = Wallet.derive(mnemonic2, networkInfo);
    final WalletInfo walletInfo = WalletInfo(wallet, mnemonic2.join(' '));
    return walletInfo;
  }

  @override
  Future<Tx> makeTransaction(
      {required Wallet wallet,
      required String toAddress,
      required String amount,
      required String fee}) async {
    //

    // Step #1 : create msgSend
    final MsgSend message = bank.MsgSend.create()
      ..fromAddress = wallet.bech32Address
      ..toAddress = toAddress;
    message.amount.add(Coin.create()
      ..denom = 'uaura'
      ..amount = amount);

    // Step #2 : create fee
    final Fee feeData = InAppWalletHelper.createFee(amount: fee);

    Tx a = await InAppWalletHelper.signTransaction(
        networkInfo: networkInfo,
        wallet: wallet,
        msgSend: [message],
        fee: feeData);
    return a;
  }

  @override
  Future<WalletInfo> restoreHDWallet({required String mnemonic}) async {
    bool isVaild = InAppWalletHelper.checkMnemonic(mnemonic: mnemonic);
    if (!isVaild) {
      throw AuraSDKError(1, "Not valid passpharse");
    }

    /// The [Wallet.derive] function take about 500 milisecond
    final wallet = Wallet.derive(mnemonic.split(' '), networkInfo);
    final WalletInfo walletInfo = WalletInfo(wallet, mnemonic);
    return walletInfo;
  }

  @override
  Future<bool> submitTransaction({required Tx signedTransaction}) async {
    // 4. Broadcast the transaction
    final txSender =
        TxSender.fromNetworkInfo(networkInfo, interceptors: [LogInter()]);
    print('#5 txSender : ${txSender}');

    final response = await txSender.broadcastTx(signedTransaction);
    print('#6 response : ${response.isSuccessful}');

    // Check the result
    if (response.isSuccessful) {
      print('#6.0 Tx sent successfully. Response: ${response}');
      return true;
    } else {
      print('#6.1 Tx errored: ${response}');
      return false;
    }
  }

  @override
  Future<String> checkWalletBalance({required String address}) async {
    final req = bank.QueryBalanceRequest(address: address, denom: 'uaura');
    print("KhoaHM request = $req");
    print("KhoaHM address = ${req.address}");
    print("KhoaHM denom = ${req.denom}");

    final client =
        bank.QueryClient(networkInfo.gRPCChannel, interceptors: [LogInter()]);

    print("KhoaHM client = $client");

    final response = await client.balance(req);
    response.balance;

    //// Đoạn code check account info
    // final auth.QueryAccountRequest req = auth.QueryAccountRequest()
    //   ..address = address;
    // final client = auth.QueryClient(networkInfo.gRPCChannel);
    // AuthQuerier authQuerier = AuthQuerier(client: client);

    // final accountData = await authQuerier.getAccountData(address);
    // print('    accountData.accountNumber ${accountData?.accountNumber}');
    // print('    accountData.sequence ${accountData?.sequence}');
    // print('    accountData.address ${accountData?.address}');
    print(response);

    return response.balance.amount;
  }

  Future<bool> checkMnemonic({required String mnemonic}) async {
    return Bip39.validateMnemonic(mnemonic.split(' '));
  }

  @override
  Future<List<AuraTransaction>> checkWalletHistory(
      {required String address}) async {
    List<AuraTransaction>? listSender =
        await _getListTransactionByAddress(address, TransactionType.send);
    List<AuraTransaction>? listRecive =
        await _getListTransactionByAddress(address, TransactionType.recive);

    List<AuraTransaction> listAllTransaction = [];
    listAllTransaction.addAll(listSender ?? []);
    listAllTransaction.addAll(listRecive ?? []);

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
        final client = auraTx.ServiceClient(networkInfo.gRPCChannel,
            interceptors: [LogInter()]);
        final GetTxsEventResponse response = await client.getTxsEvent(request);

        List<AuraTransaction> listData =
            InAppWalletHelper.convertToAuraTransaction(
                response.txResponses, transactionType);
        return listData;
      } catch (e, s) {}
      return null;
    } else if (transactionType == TransactionType.recive) {
      final request = auraTx.GetTxsEventRequest(events: [
        "transfer.recipient='$address'",
      ], pagination: PageRequest(offset: 0.toInt64(), limit: 100.toInt64()));
      try {
        final client = auraTx.ServiceClient(networkInfo.gRPCChannel,
            interceptors: [LogInter()]);
        final GetTxsEventResponse response = await client.getTxsEvent(request);

        List<AuraTransaction> listData =
            InAppWalletHelper.convertToAuraTransaction(
                response.txResponses, transactionType);
        return listData;
      } catch (e, s) {}
      return null;
    }

    return null;
  }

  ///// "balance" : {
  //       //   "address" : "aura18dftkv07h76uhmxjkrp8da4ezlsdql5sudtuxn",
  //       // }
  //
  //       // "all_accounts": {
  //       //
  //       // }
  //
  //       // "minter": {}
  //
  //       // "token_info" : {
  //       //
  //       // }
  //
  //       // "marketing_info" : {
  //       //
  //       // }
  //
  //       // "all_allowances" : {
  //       //   "owner" : "aura1s9z065kv897was45gel6wxjcddu73fmh4qwmcu"
  //       // }
  //
  //       // "allowance" : {
  //       //   "owner" : "aura1s9z065kv897was45gel6wxjcddu73fmh4qwmcu",
  //       //   "spender" : ""
  //       // }
  @override
  Future<String> makeInteractiveQuerySmartContract({
    required String contractAddress,
    required Map<String, dynamic> query,
  }) async {
    if (contractAddress.isEmpty) {
      throw UnimplementedError('Contract address is not empty');
    }

    ///validate queries
    if (query.keys.toList().length != 1) {
      throw UnimplementedError('Queries not valid');
    }

    List<int> queryData = jsonEncode(query).codeUnits;

    final cosMWasm.QueryClient client = cosMWasm.QueryClient(
        networkInfo.gRPCChannel,
        interceptors: [LogInter()]);

    final cosMWasm.QuerySmartContractStateRequest request =
        cosMWasm.QuerySmartContractStateRequest(
      address: contractAddress,
      queryData: queryData,
    );

    final cosMWasm.QuerySmartContractStateResponse response =
        await client.smartContractState(request);

    return String.fromCharCodes(response.data);
  }

  @override
  Future<String> makeInteractivePutSmartContract({
    required String contractAddress,
    required String sender,
    required Map<String, dynamic> message,
  }) async {
    throw UnimplementedError('Unimplemented, Method not support in this version');

    ///validate message
    if (contractAddress.isEmpty) {
      throw UnimplementedError('Contract address is not empty');
    }

    if (message.keys.length != 1) {
      throw UnimplementedError("Message is valid");
    }

    List<int> msg = jsonEncode(message).codeUnits;

    final cosMWasm.MsgClient client =
        cosMWasm.MsgClient(networkInfo.gRPCChannel, interceptors: [LogInter()]);

    final cosMWasm.MsgExecuteContract request = cosMWasm.MsgExecuteContract(
        contract: contractAddress, sender: sender, msg: msg, funds: []);

    final cosMWasm.MsgExecuteContractResponse response =
        await client.executeContract(request);

    auraLog.log('from default ${String.fromCharCodes(response.data)}');

    return String.fromCharCodes(response.data);
  }


  @override
  Future<String> makeInteractiveWriteSmartContract({
    required String contractAddress,
    required Wallet wallet,
    required Map<String, dynamic> executeMessage,
    List<int>? funds,
    int? fee,
  }) async {
    ///Validator
    ///
    if (contractAddress.isEmpty) {
      throw UnimplementedError('Contract address is not empty');
    }

    if (fee != null) {
      if (fee < 200) {
        throw UnimplementedError('Min fee is 200');
      }
    }

    ///1 : Create message
    ///
    final List<int> msg = jsonEncode(executeMessage).codeUnits;

    List<Coin> coins = List.empty(growable: true);

    if (funds != null) {
      coins.addAll(funds.map(
        (e) => Coin.create()
          ..amount = e.toString()
          ..denom = 'uaura',
      ));
    }

    final cosMWasm.MsgExecuteContract request = cosMWasm.MsgExecuteContract(
      contract: contractAddress,
      sender: wallet.bech32Address,
      msg: msg,
      funds: coins,
    );

    ///2 : Create fee
    final Fee feeData = InAppWalletHelper.createFee(
      amount: (fee ?? 200).toString(),
    );

    ///3 : Create and sign transaction
    Tx tx = await InAppWalletHelper.signTransaction(
      networkInfo: networkInfo,
      wallet: wallet,
      msgSend: [request],
      fee: feeData,
    );


    ///4: create tx sender
    final txSender = TxSender.fromNetworkInfo(networkInfo);

    ///5: broadcast transaction
    final response = await txSender.broadcastTx(tx);

    if (response.isSuccessful) {
      return response.txhash;
    }
    throw UnimplementedError(
        'Broadcast transaction error\n${response.rawLog}');
  }
}

class LogInter implements ClientInterceptor {
  @override
  ResponseStream<R> interceptStreaming<Q, R>(
      ClientMethod<Q, R> method,
      Stream<Q> requests,
      CallOptions options,
      ClientStreamingInvoker<Q, R> invoker) {
    return invoker(method, requests, options);
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
      CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
    auraLog.log(
      'Grpc request. '
      'method: ${method.path}, '
      'request: $request',
    );
    final response = invoker(method, request, options);

    response.then((r) {
      auraLog.log(
        'Grpc response. '
        'method: ${method.path}, '
        'response: ${r.toString()}',
      );
    });

    return response;
  }
}
