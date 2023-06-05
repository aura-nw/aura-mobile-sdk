import 'dart:math';

String uniqueId() {
  int d = DateTime.now().millisecondsSinceEpoch;

  String id = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx';

  return id.replaceAllMapped(RegExp(r'[xy]'), (match) {
    int r = Random().nextInt(16); // random number between 0 and 16
    // Use timestamp until depleted
    r = (d + r) % 16 | 0;
    d = (d / 16).floor();
    return (match.input[match.end - match.start] == 'x' ? r : (r & 0x3) | 0x8)
        .toString();
  });
}
