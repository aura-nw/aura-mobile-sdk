const String webSocket = 'websocket';
const int connectTimeOut = 600000;

List<int> crypto = List<int>.empty(growable: true)
  ..addAll([
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
  ]);

const String deNom = 'uaura';
const String bech32Hrp = 'aura';
