import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../core/listeners/aura_event_listener.dart';
import '../../core/types/aura_server_event_type.dart';

class AuraConnectWalletEventEmitter with AuraEventListener {
  AuraConnectWalletEventEmitter() {
    _eventSubscription = _eventConnectWalletStream.listen((event) {
      _observers(event);
    });
  }

  StreamSubscription<AuraServerEventType>? _eventSubscription;

  ///Handle event wallet connection
  final StreamController<AuraServerEventType> _eventController =
      StreamController.broadcast();

  Stream<AuraServerEventType> get _eventConnectWalletStream =>
      _eventController.stream;

  Sink<AuraServerEventType> get _sinkEvent => _eventController.sink;

  ///

  void emit(AuraServerEventType event) {
    _sinkEvent.add(event);
  }

  void once(String event,
      {void Function(AuraServerEventTypeData?)? data}) async {
    Completer<AuraServerEventType> completer = Completer();

    final sub = _eventConnectWalletStream.listen((newData) {
      if (newData.data?.idConnection == event) {
        completer.complete(newData);
      } else {
        completer.completeError('Force once error with data');
      }
    });

    await completer.future.then((value) async {
      data?.call(value.data);
    }).catchError((error) {
      data?.call(AuraServerEventTypeData(
        idConnection: event,
        result: false,
      ));
    }).whenComplete(
      () async => await sub.cancel(),
    );
  }

  @mustCallSuper
  void close() async {
    if (_eventSubscription != null) {
      await _eventSubscription!.cancel();

      _eventSubscription = null;
    }

    if (!_eventController.isClosed) {
      _eventController.close();
    }
  }

  void _observers(AuraServerEventType data) {
    for (final listener in listeners) {
      listener.call(
        data,
      );
    }
  }
}
