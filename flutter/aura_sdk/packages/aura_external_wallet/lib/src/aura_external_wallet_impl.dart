import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:aura_external_wallet/aura_external_wallet.dart';
import 'package:aura_launcher/aura_launcher.dart';
import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'core/aura_external_wallet_emitter.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';

import 'core/type_data/external_type_data.dart';
import 'core/types/aura_server_event_type.dart';

const crypto = [
  0x10,
  0x91,
  0x56,
  0xbe,
  0xc4,
  0xfb,
  0xc1,
  0xea,
  0x71,
  0xb4,
  0xef,
  0xe1,
  0x67,
  0x1c,
  0x58,
  0x36,
];

class AuraExternalWalletImpl implements AuraExternalWallet {
  final String appName;
  final String appLogo;
  final String callBackUrl;
  final AuraExternalWalletEnvironment environment;
  final String chainId;

  Socket? _socketClient;

  AuraExternalWalletImpl(
    this.appName,
    this.appLogo,
    this.callBackUrl,
    this.environment,
  ) : chainId = environment == AuraExternalWalletEnvironment.testNet
            ? 'serenity-testnet-001'
            : environment == AuraExternalWalletEnvironment.euphoria
                ? 'euphoria-2'
                : 'xstaxy-1' {
    _createSocket();
  }

  void _createSocket() {
    if (_isSocketConnected) return;

    if (_socketClient != null) {
      _socketClient?.connect();
    } else {
      OptionBuilder otpBuilder = OptionBuilder()
        ..setTransports(
          ['webSocket'],
        )
        ..setTimeout(600000)
        ..enableAutoConnect()
        ..enableForceNew();

      Map<String, dynamic> options = otpBuilder.build();

      _socketClient = io(
        'https://socket.coin98.services/',
        options,
      );

      _socketClient?.on('sdk_connect', (event) {
        if (event is Map<String, dynamic>) {
          AuraSocketServerEventType fromEvent =
              AuraSocketServerEventType.fromJson(event);

          String? id = fromEvent.data?.idConnection;

          if (id == '' || id == null) return;

          emitter.emit(
            fromEvent,
          );
        }
      });

      _socketClient?.on('disconnect', (event) {
        _isSocketConnected = false;
        isConnected = false;
        emitter.emit(
          const AuraSocketServerEventType(
            type: 'disconnect',
            data: null,
          ),
        );
      });

      _isSocketConnected = true;
    }
  }

  bool isConnected = false;
  bool _isSocketConnected = false;
  String? _id;

  final AuraExternalWalletEmitter emitter = AuraExternalWalletEmitter();

  @override
  Future sendTransaction() async {
    throw UnimplementedError();
  }

  @override
  Future signContract() async {
    throw UnimplementedError();
  }

  Future<AuraSocketServerEventTypeData> _requestCore(
    String connectionId, {
    required Map<String, dynamic> param,
  }) async {
    if (!isConnected && param['method'] != 'connect') {
      throw AuraExternalError(
        101,
        'You need to connect before handle any request!!',
      );
    }

    if (callBackUrl.isEmpty) {
      throw AuraExternalError(
        102,
        'You need provider your app url!!',
      );
    }

    if (connectionId.isEmpty) {
      throw AuraExternalError(103, 'Wait Id From Coin98');
    }

    int d = DateTime.now().millisecondsSinceEpoch;

    ///generate auto id
    String idFormat = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx';

    String id = idFormat.replaceAllMapped(RegExp(r'[xy]'), (match) {
      int r = Random().nextInt(16);
      r = (d + r) % 16 | 0;
      d = (d / 16).floor();
      return (match.input[match.end - match.start] == 'x' ? r : (r & 0x3) | 0x8)
          .toString();
    });

    param['id'] = id;

    param['redirect'] = Uri.encodeFull(callBackUrl);

    param['chain'] = chainId;

    String url = _enCodeUrl('$id&request=${_enCodeRequestParam(
      param,
    )}');

    AuraLauncher.instance.openUrl(url);

    Completer<AuraSocketServerEventTypeData> completer = Completer();

    return completer.future;
  }

  String _enCodeUrl(String url) {
    url = Uri.encodeComponent(url);

    return url.startsWith('coin98://') ? url : 'coin98://$url';
  }

  String _enCodeRequestParam(
    Map<String, dynamic> params,
  ) {
    return Uri.encodeComponent(jsonEncode(params));
  }

  @override
  Future<AuraWalletConnectionResult> connectWallet() async {
    if (!_isSocketConnected) {
      _createSocket();
    }

    final id = const Uuid().v4(
      config: V4Options(
        crypto,
        CryptoRNG(),
      ),
    );

    final Map<String, dynamic> emitData = {
      "type": "connection_request",
      "message": {
        "url": callBackUrl,
        "id": id,
      }
    };

    Completer<AuraWalletConnectionResult> completer = Completer();

    _socketClient?.emitWithAck('coin98_connect', emitData,
        ack: (String connectionId) async {
      _id = connectionId;
      await _sendTheRequestConnection(connectionId).then((data) {
        isConnected = true;

        completer.complete(
          AuraWalletConnectionResult(
            idConnection: data.idConnection,
            result: true,
          ),
        );
      }).catchError((error) {
        completer.completeError(error);
      });
    });

    return completer.future;
  }

  Future<AuraSocketServerEventTypeData> _sendTheRequestConnection(
    String connectionId,
  ) async {
    if (!isConnected) {
      Map<String, dynamic> connectionParams = {
        'method': 'connect',
        'params': [
          {
            'name': appName,
            'callbackURL': callBackUrl,
            'logo': appLogo,
          }
        ]
      };
      return await _requestCore(
        connectionId,
        param: connectionParams,
      );
    }

    return Future.error(
      'Wallet ready connection!',
    );
  }

  @override
  Future<AuraConnectWalletInfoResult> requestAccountInfo() async {
    Map<String, dynamic> requestParam = {
      'method': 'cosmos_getKey',
      'params': [
        chainId,
      ]
    };

    final AuraSocketServerEventTypeData data = await _requestCore(
      _id ?? '',
      param: requestParam,
    );

    return AuraConnectWalletInfoResult(
      data: AuraExternalWalletInfo.fromJson(data.result),
      idConnection: data.idConnection,
    );
  }

  void _disconnect() {
    _isSocketConnected = false;
    isConnected = false;
    _socketClient?.disconnect();
  }

  @override
  void dispose() {
    _disconnect();
    if (_socketClient != null) {
      _socketClient?.dispose();
    }
    emitter.close();
  }
}
