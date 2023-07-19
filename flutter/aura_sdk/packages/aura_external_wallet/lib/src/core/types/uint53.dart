import 'int53.dart';

class Uint53 {
  late Int53 data;

  Uint53(int input) {
    final Int53 signed = Int53(input);
    if (signed.data < 0) {
      throw UnimplementedError("Input is negative");
    }
    data = signed;
  }

  factory Uint53.fromString(String str) {
    final Int53 signed = Int53.fromString(str);
    return Uint53(signed.data);
  }

  @override
  String toString() {
    return data.toString();
  }
}
