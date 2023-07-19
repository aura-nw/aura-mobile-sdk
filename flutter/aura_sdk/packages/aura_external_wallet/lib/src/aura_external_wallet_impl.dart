import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;
import 'package:aura_external_wallet/aura_external_wallet.dart';
import 'package:aura_external_wallet/src/core/types/cosmos_type.dart';
import 'package:aura_launcher/aura_launcher.dart';
import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'core/aura_external_wallet_emitter.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';

import 'core/type_data/external_type_data.dart';
import 'core/types/aura_server_event_type.dart';

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

  String get _denom => environment == AuraExternalWalletEnvironment.testNet
      ? 'uaura'
      : environment == AuraExternalWalletEnvironment.euphoria
          ? 'ueaura'
          : 'uaura';

  void _createSocket() {
    if (_isSocketConnected) return;

    if (_socketClient != null) {
      _socketClient?.connect();
    } else {
      OptionBuilder otpBuilder = OptionBuilder()
        ..setTransports(
          ['websocket'],
        )
        ..setTimeout(60000)
        ..enableAutoConnect()
        ..enableForceNew();

      Map<String, dynamic> options = otpBuilder.build();

      _socketClient = io(
        'https://socket.coin98.services/',
        options,
      );

      _socketClient?.connect();

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
  Future<String> sendTransaction({
    required String signer,
    required String toAddress,
    required String amount,
    required String fee,
    String? memo,
  }) async {
    if (!_isSocketConnected) {
      _createSocket();
    }

    try {
      int.parse(amount);
    } catch (e) {
      throw AuraExternalError(
          104, 'Format exception\nAmount has type not valid');
    }
    try {
      int.parse(fee);
    } catch (e) {
      throw AuraExternalError(105, 'Format exception\nFee has type not valid');
    }

    String baseUrl = _getBaseUrl();
    try {
      HttpClient client = HttpClient();

      final request = await client.getUrl(Uri.parse(
          '$baseUrl/api/v1/account-info?address=$signer&chainId=$chainId'));

      final HttpClientResponse response = await request.close();

      final String dataString =
          await (response.transform(utf8.decoder).join()).whenComplete(
        () => client.close(),
      );

      Map<String, dynamic> account = jsonDecode(dataString);

      if (account['code'] == null || account['code'] != 200) {
        throw AuraExternalError(108, 'Can not get Account');
      }

      String? accountNumber =
          account['data']['account_auth']['account']['account_number'];
      String? sequence = account['data']['account_auth']['account']['sequence'];

      if (accountNumber == null || sequence == null) {
        throw AuraExternalError(108, 'Can not get Account');
      }

      StdSignDoc signDoc = StdSignDoc.makeSignDoc(
        fee: StdFee(
          coins: [
            Coin(
              amount: fee,
              denom: _denom,
            ),
          ],
        ),
        chainId: chainId,
        accountNumber: accountNumber,
        sequence: sequence,
        memo: memo ?? '',
        msgs: [
          AminoMessage(
            urlType: '/cosmos.bank.v1beta1.MsgSend',
            value: {
              'fromAddress': signer,
              'toAddress': toAddress,
              'amount': [
                {
                  'denom': _denom,
                  'amount': amount,
                }
              ],
            },
          ),
        ],
      );

      final Map<String, dynamic> params = {
        'method': 'cosmos_signAndBroadcast',
        'params': [
          {
            'signer': signer,
            'chainId': chainId,
            'isDirect': false,
            'signDoc': signDoc.toSignDoc(),
          }
        ],
      };

      dev.log(params.toString());

      final AuraSocketServerEventTypeData data = await _requestCore(
        _id,
        param: params,
      );

      final Map<String, dynamic> result = data.result;

      if (result.isEmpty ||
          result['code'] != 0 ||
          result['transactionHash'] == null) {
        throw AuraExternalError(
            152, result['rawLog']?.toString() ?? 'Send transaction error');
      }

      return result['transactionHash'] as String;
    } catch (e) {
      print(e.toString());
      if(e is AuraExternalError){
        rethrow;
      }
      throw AuraExternalError(108, 'Can not get Account');
    }
  }

  @override
  Future<String> executeContract({
    required String signer,
    required String contractAddress,
    required Map<String, dynamic> executeMessage,
    List<int>? funds,
    int? fee,
  }) async {
    if (!_isSocketConnected) {
      _createSocket();
    }

    if (contractAddress.isEmpty) {
      throw AuraExternalError(106, 'Contract address is not empty');
    }

    if (fee != null) {
      if (fee < 200) {
        throw AuraExternalError(107, 'Min fee is 200');
      }
    }

    List<Map<String, dynamic>> coins = List.empty(growable: true);

    if (funds != null) {
      coins.addAll(
        funds.map(
          (e) => {
            'denom': _denom,
            'amount': e,
          },
        ),
      );
    }

    final Map<String, dynamic> params = {
      'method': 'cosmos_execute',
      'params': [
        {
          'signer': signer,
          'chainId': chainId,
          'contractAddress' : contractAddress,
          'msg' : executeMessage,
          'memo': 'Auto for dev',
          'fee': {
            'gasPrice': [
              {
                'denom': _denom,
                'amount': fee,
              }
            ],
          },
        }
      ],
    };

    dev.log(params.toString());

    final AuraSocketServerEventTypeData data = await _requestCore(
      _id,
      param: params,
    );

    final Map<String, dynamic> result = data.result;

    if (result.isEmpty ||
        result['code'] != 0 ||
        result['transactionHash'] == null) {
      throw AuraExternalError(
          152, result['rawLog']?.toString() ?? 'Send transaction error');
    }

    return result['transactionHash'] as String;
  }

  Future<AuraSocketServerEventTypeData> _requestCore(
    String? connectionId, {
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

    if ((connectionId ?? '').isEmpty) {
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

    String url = _enCodeUrl('$connectionId&request=${_enCodeRequestParam(
      param,
    )}');

    AuraLauncher.instance.openUrl(url);

    Completer<AuraSocketServerEventTypeData> completer = Completer();

    emitter.once(id, data: (data) {
      final result = data?.result;

      dev.log((data?.result).toString());

      if (data == null || result == false || result == null) {
        completer.completeError(
          AuraExternalError(
            150,
            'Request ${data?.idConnection} Connect Wallet Sdk Error\nUser don\'t allow',
          ),
        );
      } else if (result is Map<String, dynamic> &&
          (result['error'] != null || result['errors'] != null)) {
        completer.completeError(
          AuraExternalError(
            151,
            'Request ${data.idConnection} Connect Wallet Sdk Error $result',
          ),
        );
      } else {
        completer.complete(data);
      }
    });

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
        [
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
        ],
        CryptoRNG(),
      ),
    );

    dev.log('Generate id =$id');

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
      dev.log('connection id = $connectionId');
      _id = connectionId;

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
        final result = await _requestCore(
          connectionId,
          param: connectionParams,
        );

        isConnected = true;

        completer.complete(
          AuraWalletConnectionResult(
            idConnection: result.idConnection,
            result: true,
          ),
        );
      } else {
        completer.completeError(
          'Wallet ready connection!',
        );
      }
    });

    return completer.future;
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
      _id,
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

  String _getBaseUrl(){
    String baseUrl;
    switch (environment) {
      case AuraExternalWalletEnvironment.testNet:
        baseUrl = 'https://indexer.dev.aurascan.io';
        break;
      case AuraExternalWalletEnvironment.euphoria:
        baseUrl = 'https://indexer.staging.aurascan.io';
        break;
      case AuraExternalWalletEnvironment.mainNet:
        baseUrl = 'https://horoscope.aura.network';
        break;
    }
    return baseUrl;
  }
}
