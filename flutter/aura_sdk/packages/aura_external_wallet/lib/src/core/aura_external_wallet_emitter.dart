import 'dart:async';
import 'package:flutter/foundation.dart';

import 'types/aura_server_event_type.dart';

typedef AuraConnectWalletListener = void Function(AuraSocketServerEventType data);

class AuraExternalWalletEmitter {
  AuraExternalWalletEmitter() {
    _eventSubscription = connectWalletStream.listen((event) {
      _observers(event);
    });
  }

  StreamSubscription<AuraSocketServerEventType>? _eventSubscription;

  ///Handle event wallet connection
  final StreamController<AuraSocketServerEventType> _eventController =
  StreamController.broadcast();

  Stream<AuraSocketServerEventType> get connectWalletStream =>
      _eventController.stream;

  Sink<AuraSocketServerEventType> get _sinkEvent => _eventController.sink;

  ///

  void emit(AuraSocketServerEventType event) {
    _sinkEvent.add(event);
  }

  void once(String event,
      {void Function(AuraSocketServerEventTypeData?)? data}) async {
    Completer<AuraSocketServerEventType> completer = Completer();

    final sub = connectWalletStream.listen((newData) {
      if (newData.data?.idConnection == event) {
        completer.complete(newData);
      } else {
        completer.completeError('Force once error with data');
      }
    });

    await completer.future.then((value) async {
      data?.call(value.data);
    }).catchError((error) {
      data?.call(AuraSocketServerEventTypeData(
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

  void _observers(AuraSocketServerEventType data) {
    for (final listener in listeners) {
      listener.call(
        data,
      );
    }
  }

  final List<AuraConnectWalletListener> _listeners = List.empty(growable: true);

  void addListener(AuraConnectWalletListener listener) {
    if (_listeners.contains(listener)) return;
    _listeners.add(listener);
  }

  void clearListener() {
    _listeners.clear();
  }

  void removeListener(AuraConnectWalletListener listener) {
    if (_listeners.contains(listener)) {
      _listeners.remove(listener);
    }
  }

  List<AuraConnectWalletListener> get listeners => _listeners;
}
