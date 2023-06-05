import '../types/aura_server_event_type.dart';

typedef AuraConnectWalletListener = void Function(AuraServerEventType data);

class AuraEventListener {
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
