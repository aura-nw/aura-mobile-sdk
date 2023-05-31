import 'dart:async';
import 'dart:math';

import 'package:aura_sdk/src/inapp_wallet/inapp_wallet.dart';
import 'package:aura_sdk/src/external_wallet/external_wallet.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'package:uuid/uuid.dart';

import 'constants/constant.dart';
import 'core/core_data/aura_wallet_core_data.dart';
import 'core/types/aura_server_event_type.dart';
import 'core/utils/encode_rq.dart';
import 'core/utils/open_url.dart';

class ExternalWalletImpl extends ExternalWallet {
  final String appName;
  final String appLogo;
  final String callBackUrl;
  final String chainId;

  final Uuid _uuid = const Uuid();

  late Socket socketClient;

  ExternalWalletImpl(this.appName, this.appLogo, this.callBackUrl,
      {this.chainId = 'serenity-testnet-001'}) {
    createSocket();
  }

  void createSocket() {
    OptionBuilder otpBuilder = OptionBuilder()
      ..setTransports(
        [webSocket],
      )
      ..setTimeout(connectTimeOut)
      ..enableAutoConnect()
      ..enableForceNew();

    Map<String, dynamic> options = otpBuilder.build();

    socketClient = io(
      'https://socket.coin98.services/',
      options,
    );

    socketClient.on('sdk_connect', (event) {
      print("#sdk_connect $event");
    });

    socketClient.on('disconnect', (event) {
      print("#disconnect $event");
    });
  }

  // }

  @override
  Future<AuraWalletConnectionResult> connectWalletSdk() async {
    Completer<AuraWalletConnectionResult> completer = Completer();

    return await completer.future;
  }

  @override
  Future requestAccountInfo() {
    // TODO: implement requestAccountInfo
    throw UnimplementedError();
  }

  @override
  Future sendTransaction(String fromAddress, String toAddress) {
    // TODO: implement sendTransaction
    throw UnimplementedError();
  }

  @override
  Future signContract(String contractAddress) {
    // TODO: implement signContract
    throw UnimplementedError();
  }

  @override
  Future connectWallet() async {
    final id = const Uuid().v4(
      config: V4Options(
        crypto,
        CryptoRNG(),
      ),
    );

    final Map<String, dynamic> emitData = {
      "type": "connection_request",
      "message": {"url": callBackUrl, "id": id}
    };

    socketClient.emitWithAck('coin98_connect', emitData,
        ack: (String connectionId) async {
      sendTheRequestConnection(connectionId);
    });
  }

  bool isConnected = false;
  Future<void> sendTheRequestConnection(String connectionId) async {
    if (!isConnected) {
      Map<String, dynamic> connectionParams = {
        'method': 'connect',
        'name': appName,
        'callbackURL': callBackUrl,
        'logo': appLogo,
      };
      await _requestCore(
        connectionId,
        param: connectionParams,
      );
    }
  }

  @override
  void dispose() {}

  Future<AuraServerEventTypeData> _requestCore(String connectionId,
      {required Map<String, dynamic> param}) async {
    print('KhoaHM ##Request Core##  params = $param');

    if (!isConnected && param['method'] != 'connect') {
      throw UnimplementedError(
          'You need to connect before handle any request!!');
    }

    if (callBackUrl.isEmpty) {
      throw UnimplementedError('You need provider your app url!!');
    }

    if (connectionId.isEmpty) {
      throw UnimplementedError('Wait Id From Coin98');
    }

    int d = DateTime.now().millisecondsSinceEpoch;

    ///generate auto id
    String idFormat = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx';

    String id = idFormat.replaceAllMapped(RegExp(r'[xy]'), (match) {
      int r = Random().nextInt(16); // random number between 0 and 16
      // Use timestamp until depleted
      r = (d + r) % 16 | 0;
      d = (d / 16).floor();
      return (match.input[match.end - match.start] == 'x' ? r : (r & 0x3) | 0x8)
          .toString();
    });

    param['id'] = id;

    param['redirect'] = Uri.encodeFull(callBackUrl);

    param['chain'] = 'serenity-testnet-001';

    String url = enCodeUrl('$id&request=${enCodeRequestParam(
      param,
    )}');

    OpenUrl openUrl = const OpenUrl();
    openUrl.openUrl(url);

    Completer<AuraServerEventTypeData> completer = Completer();

    return completer.future;
  }
}
