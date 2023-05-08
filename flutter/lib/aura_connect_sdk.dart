library aura_mobile_sdk;

import 'dart:async';
import 'package:aura_mobile_sdk/src/constants/server.dart';
import 'package:flutter/foundation.dart';
import 'src/aura_mobile_sdk.dart';
import 'src/connect_wallet/aura_connect_wallet.dart';
import 'src/core/parameters/aura_parameter.dart';
import 'src/core/core_data/aura_wallet_core_data.dart';
import 'src/core/types/aura_server_event_type.dart';
export 'src/core/core_data/aura_wallet_core_data.dart';
export 'src/core/parameters/aura_parameter.dart';
export 'src/core/types/aura_server_event_type.dart';

import 'package:alan/alan.dart';
import 'package:alan/proto/cosmos/bank/v1beta1/tx.pb.dart';
import 'src/core/in_app_core_data/in_app_core_data.dart';
import 'src/in_app_wallet/aura_in_app_wallet_client.dart';

export 'src/core/in_app_core_data/in_app_core_data.dart';
export 'package:alan/alan.dart' show Fee, Tx , Wallet;
export 'package:alan/proto/cosmos/bank/v1beta1/tx.pb.dart' show MsgSend;

/// region Aura connect sdk
class AuraConnectSdkParameter {
  final String callbackUrl;
  final String yourAppName;
  final String yourAppLogo;

  const AuraConnectSdkParameter({
    required this.callbackUrl,
    this.yourAppLogo = '',
    required this.yourAppName,
  });
}

class AuraConnectSdk implements AuraMobileSdk<AuraConnectSdkParameter> {
  AuraConnectSdk();

  String _chainId = '';

  AuraConnectWalletClient? _client;

  @override
  Future<void> init({
    AuraWalletEnvironment environment = AuraWalletEnvironment.testNet,
    AuraConnectSdkParameter? parameter,
  }) async {
    assert(parameter != null, 'You must provider Aura connect sdk parameter');
    switch (environment) {
      case AuraWalletEnvironment.mainNet:
        break;
      case AuraWalletEnvironment.testNet:
        _chainId = 'serenity-testnet-001';
        break;
    }

    _client = AuraConnectWalletClient(
      callbackURL: parameter!.callbackUrl,
      dAppLogo: parameter.yourAppLogo,
      dAppName: parameter.yourAppName,
      chainId: _chainId,
    );

    isReadyInit = true;
  }

  Future<AuraWalletConnectionResult> connectWallet() async {
    if (!isReadyInit || _client == null) {
      throw UnimplementedError('You must call init before connect wallet');
    }

    return _client!.connectWalletSdk();
  }

  Future<AuraWalletInfoData> requestAccessWallet() async {
    if (!isReadyInit || _client == null) {
      throw UnimplementedError('You must call init before connect wallet');
    }

    return _client!.requestAccessWalletSdk();
  }

  Future<Map<String, dynamic>> transfer({required TransferParam param}) async {
    if (!isReadyInit || _client == null) {
      throw UnimplementedError('You must call init before connect wallet');
    }

    return _client!.transfer(
      param: param,
    );
  }

  void addListener(void Function(AuraServerEventType data) listener) {
    _client?.addListener(listener);
  }

  void removeListener(void Function(AuraServerEventType data) listener) {
    _client?.removeListener(listener);
  }

  void clearListener() {
    _client?.clearListener();
  }

  @mustCallSuper
  void connect() {
    _client?.connect();
  }

  @mustCallSuper
  void disconnect() {
    _client?.disconnect();
  }

  @mustCallSuper
  void dispose() {
    isReadyInit = false;
    _client?.dispose();
  }

  @override
  bool isReadyInit = false;
}

///endregion

///region AuraInAppWalletSdk
class AuraInAppWalletSdk implements AuraMobileSdk<void> {
  AuraInAppWalletClient? _client;

  @override
  bool isReadyInit = false;

  @override
  Future<void> init({
    AuraWalletEnvironment environment = AuraWalletEnvironment.testNet,
    void parameter,
  }) async {
    LCDInfo lcdInfo;
    GRPCInfo grpcInfo;

    switch (environment) {
      case AuraWalletEnvironment.testNet:
        lcdInfo = LCDInfo(
          host: lcdTestNet,
          port: 443,
        );
        grpcInfo = GRPCInfo(
          host: grpcTestNet,
          port: 9092,
        );
        break;
      case AuraWalletEnvironment.mainNet:
        lcdInfo = LCDInfo(
          host: lcdMainNet,
        );
        grpcInfo = GRPCInfo(
          host: grpcMainNet,
        );
        break;
    }

    _client = AuraInAppWalletClient(
      lcdInfo: lcdInfo,
      grpcInfo: grpcInfo,
    );

    isReadyInit = true;
  }

  Future<AuraInAppWalletInfo> createRandomHDWallet() async {
    if (!isReadyInit || _client == null) {
      throw UnimplementedError('You must call init before used aura sdk');
    }

    return _client!.createRandomHDWallet();
  }

  Future<AuraInAppWalletInfo> restoreHDWallet(
      {required String mnemonic}) async {
    if (!isReadyInit || _client == null) {
      throw UnimplementedError('You must call init before used aura sdk');
    }

    return _client!.restoreHDWallet(
      mnemonic: mnemonic,
    );
  }

  Future<bool> checkMnemonic({required String mnemonic}) async {
    if (!isReadyInit || _client == null) {
      throw UnimplementedError('You must call init before used aura sdk');
    }

    return _client!.checkMnemonic(
      mnemonic: mnemonic,
    );
  }

  Future<MsgSend> createTransaction({
    required String fromAddress,
    required String toAddress,
    required String amount,
  }) async {
    if (!isReadyInit || _client == null) {
      throw UnimplementedError('You must call init before used aura sdk');
    }

    return _client!.createTransaction(
      fromAddress: fromAddress,
      toAddress: toAddress,
      amount: amount,
    );
  }

  Future<Fee> createFee({required String amount}) async {
    if (!isReadyInit || _client == null) {
      throw UnimplementedError('You must call init before used aura sdk');
    }
    return _client!.createFee(
      amount: amount,
    );
  }

  Future<Tx> signTransaction({
    required Wallet wallet,
    required List<MsgSend> msgSend,
    required Fee fee,
  }) async {
    if (!isReadyInit || _client == null) {
      throw UnimplementedError('You must call init before used aura sdk');
    }

    return _client!.signTransaction(
      wallet: wallet,
      msgSend: msgSend,
      fee: fee,
    );
  }

  Future<bool> submitTransaction({required Tx signedTransaction}) async {
    if (!isReadyInit || _client == null) {
      throw UnimplementedError('You must call init before used aura sdk');
    }

    return _client!.submitTransaction(
      signedTransaction: signedTransaction,
    );
  }

  Future<String> checkWalletBalance({required String address}) async {
    if (!isReadyInit || _client == null) {
      throw UnimplementedError('You must call init before used aura sdk');
    }

    return _client!.checkWalletBalance(
      address: address,
    );
  }

  Future<List<AuraTransaction>> checkWalletHistory(
      {required String address}) async {
    if (!isReadyInit || _client == null) {
      throw UnimplementedError('You must call init before used aura sdk');
    }

    return _client!.checkWalletHistory(
      address: address,
    );
  }
}
///endregion
