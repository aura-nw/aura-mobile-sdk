const int maxInteger = 0x7FFFFFFFFFFFFFFF;
const int minInteger = -0x8000000000000000;

class Int53 {
  final int data;

  Int53(this.data) {
    if (data.isNaN) {
      throw UnimplementedError("Input is not a number");
    }

    if (data < minInteger || data > maxInteger) {
      throw UnimplementedError("Input not in int53 range: $data");
    }
  }

  factory Int53.fromString(String str) {
    int ?parse = int.tryParse(str);

    if(parse == null){
      throw UnimplementedError("Invalid string format");
    }

    return Int53(
      int.parse(
        str,
        radix: 10,
      ),
    );
  }

  @override
  String toString() {
    return data.toString();
  }
}
