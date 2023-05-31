import 'package:aura_sdk/src/external_wallet/core/utils/core_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';
import '../constants/constant.dart';
import '../constants/server.dart';
import '../core/core_data/aura_wallet_core_data.dart';
import '../core/parameters/aura_parameter.dart';
import '../core/types/aura_server_event_type.dart';
import '../core/utils/encode_rq.dart';
import '../core/utils/open_url.dart';
import '../core/utils/unique_id.dart';
import 'core/aura_connect_wallet_event_emitter.dart';

class AuraConnectWalletClient extends AuraConnectWalletEventEmitter {
  Socket? _client;
  String? _id;

  bool isConnected = false;
  bool _isSocketConnected = false;

  ///support open browser
  final OpenUrl _openUrl = const OpenUrl();

  ///support get device info
  final Uuid _uuid = const Uuid();

  final String chainId;
  final String callbackURL;
  final String dAppName;
  final String dAppLogo;

  AuraConnectWalletClient({
    required this.callbackURL,
    required this.dAppName,
    required this.dAppLogo,
    required this.chainId,
  })  : assert(callbackURL.isNotNullOrEmpty),
        super() {
    _id = _uuid.v4(
      config: V4Options(
        crypto,
        CryptoRNG(),
      ),
    );

    connect();
  }

  AuraConnectWalletEventEmitter get _emitter => this;

  /// Connect to your wallet
  Future<AuraWalletConnectionResult> connectWalletSdk() async {
    _checkSocketNull();

    if (chainId.isNull) {
      throw UnimplementedError('Chain Id is required');
    }

    if (dAppName.isNullOrEmpty) {
      throw UnimplementedError('Provider your app name before continue');
    }

    ///reset uuid for new request connect
    _id = _uuid.v4(
      config: V4Options(
        crypto,
        CryptoRNG(),
      ),
    );

    final ConnectEmitData emitData = ConnectEmitData(
      type: 'connection_request',
      message: ConnectEmitMessage(
        dAppUrl: callbackURL,
        id: _id,
      ),
    );

    Completer<AuraWalletConnectionResult> completer = Completer();

    print('KhoaHM #1 coin98_connect params = ${emitData.toJson()}');
    _client!.emitWithAck('coin98_connect', emitData.toJson(),
        ack: (String id) async {
      _id = id;
      print('KhoaHM #2 coin98_connect response = $id');
      if (!isConnected) {
        AuraRequestConnectWalletParam connectParam =
            AuraRequestConnectWalletParam(params: [
          AuraConnectWalletOption(
              appName: dAppName, logo: dAppLogo, dAppUrl: callbackURL)
        ]);

        await _requestCore(
          param: connectParam.toJson(),
        ).then((data) {
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
      } else {
        completer.completeError(
          UnimplementedError(
            'Wallet ready connection!',
          ),
        );
      }
    });

    return await completer.future;
  }

  Future<AuraWalletInfoData> requestAccessWalletSdk() async {
    AuraRequestAccessWalletParam requestParam = AuraRequestAccessWalletParam(
      params: [
        chainId,
      ],
    );
    print('requestParams = ${requestParam.toJson()}');

    final AuraServerEventTypeData data = await _requestCore(
      param: requestParam.toJson(),
    );

    return AuraWalletInfoData(
      data: AuraWalletInfo.fromJson(data.result),
      idConnection: data.idConnection,
    );
  }

  FutureOr<Map<String, dynamic>> transfer(
      {required TransferParam param}) async {
    final AuraServerEventTypeData data = await _requestCore(
      param: param.toJson(),
    );

    return {};
  }

  Future<AuraServerEventTypeData> _requestCore(
      {required Map<String, dynamic> param}) async {
    print('KhoaHM ##Request Core##  params = $param');

    if (!isConnected && param['method'] != 'connect') {
      throw UnimplementedError(
          'You need to connect before handle any request!!');
    }

    if (callbackURL.isNullOrEmpty) {
      throw UnimplementedError('You need provider your app url!!');
    }

    if (_id.isNullOrEmpty) {
      throw UnimplementedError('Wait Id From Coin98');
    }

    ///generate auto id
    String id = uniqueId();

    param['id'] = id;

    param['redirect'] = Uri.encodeFull(callbackURL);

    param['chain'] = chainId;

    String url = enCodeUrl('$_id&request=${enCodeRequestParam(
      param,
    )}');

    print('requestId = $_id');
    print('url = $url');

    Completer<AuraServerEventTypeData> completer = Completer();

    _emitter.once(id, data: (data) {
      final result = data?.result;

      if (data == null || result == false) {
        completer.completeError(UnimplementedError(
            'Request ${data?.idConnection} Connect Wallet Sdk Error'));
      } else if (result is Map<String, dynamic> &&
          (result['error'] != null || result['errors'] != null)) {
        completer.completeError(UnimplementedError(
            'Request ${data.idConnection} Connect Wallet Sdk Error $result'));
      } else {
        completer.complete(data);
      }
    });
    print('KhoaHM ##Request Core##  DeepLink Url = $url');

    _openUrl.openUrl(url);

    return completer.future;
  }

  @mustCallSuper
  void connect() {
    if (!_isSocketConnected) {
      if (_client == null) {
        OptionBuilder otpBuilder = OptionBuilder()
          ..setTransports(
            [webSocket],
          )
          ..setTimeout(connectTimeOut)
          ..enableAutoConnect()
          ..enableForceNew();

        Map<String, dynamic> options = otpBuilder.build();

        _client = io(
          server,
          options,
        );

        if (_client != null) {
          _client!.on(
            'sdk_connect',
            (event) {
              print('KhoaHM ##SocketEvent##  sdk_connect event = $event');

              if (event is Map<String, dynamic>) {
                AuraServerEventType fromEvent =
                    AuraServerEventType.fromJson(event);

                String? id = fromEvent.data?.idConnection;

                if (id.isNullOrEmpty) return;

                _emitter.emit(
                  fromEvent,
                );
              }
            },
          );

          _client!.on(
            'disconnect',
            (data) {
              print('KhoaHM ##SocketEvent##  disconnect data = $data');

              isConnected = false;
              _emitter.emit(
                const AuraServerEventType(
                  type: 'disconnect',
                  data: null,
                ),
              );
            },
          );
        }
      } else {
        _client?.connect();
      }

      _isSocketConnected = true;
    }
  }

  @mustCallSuper
  void disconnect() {
    _isSocketConnected = false;
    isConnected = false;

    if (_client != null) {
      _client?.disconnect();
    }
  }

  @mustCallSuper
  void dispose() {
    isConnected = false;
    _isSocketConnected = false;

    if (_client != null) {
      _client?.dispose();
    }
    return _emitter.close();
  }

  void _checkSocketNull() {
    if (_client == null) {
      throw UnimplementedError('Socket client not initialize');
    }
  }
}
