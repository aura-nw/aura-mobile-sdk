Alphabet btcAlphabet =
    Alphabet('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz');

class Alphabet {
  late List<int> decode; // = List(128);
  late List<int> encode; // 58

  Alphabet(String s) {
    if (s.length != 58) {
      throw UnimplementedError('base58 alphabets must be 58 bytes long');
    }
    encode = s.codeUnits;

    decode = List<int>.filled(128, -1);

    var distinct = 0;
    encode.asMap().forEach((i, b) {
      if (decode[b] == -1) {
        distinct++;
      }
      decode[b] = i & 0xff;
    });

    if (distinct != 58) {
      throw UnimplementedError(
          'provided alphabet does not consist of 58 distinct characters');
    }
  }
}

class Base58 {
  const Base58();

  String base58Encode(List<int> bin) {
    return _base58Encoding(bin, btcAlphabet);
  }

  List<int> base58Decode(String str) {
    return _base58Decoding(str, btcAlphabet);
  }

  String _base58Encoding(List<int> bin, Alphabet alphabet) {
    int size = bin.length;

    int zCount = 0;
    for (; zCount < size && bin[zCount] == 0;) {
      zCount++;
    }

    size = (zCount + (size - zCount) * 555 ~/ 406 + 1);

    List<int> out = List<int>.filled(size, 0);

    int i = 0, high = 0;

    high = size - 1;

    for (int b in bin) {
      i = size - 1;
      for (int carry = b; i > high || carry != 0; i--) {
        carry = (carry + 256 * (out[i])) & 0xffffffff;
        out[i] = carry % 58;
        carry = carry ~/ 58;
      }
      high = i;
    }

    for (i = zCount; i < size && out[i] == 0; i++) {}

    List<int> val = out.sublist(i - zCount);
    size = val.length;
    for (i = 0; i < size; i++) {
      out[i] = alphabet.encode[val[i]];
    }

    return String.fromCharCodes(out.sublist(0, size));
  }

  List<int> _base58Decoding(String str, Alphabet alphabet) {
    bool support64 = (0xFFFFFFFF + 1).toUnsigned(64) != 0;

    if (str.isEmpty) {
      throw UnimplementedError('zero length string');
    }

    int zero = alphabet.encode[0];
    int b58sz = str.length;

    int zCount = 0;
    for (int i = 0; i < b58sz && str.runes.toList()[i] == zero; i++) {
      zCount++;
    }

    int c = 0; // u64
    int t = 0;

    List<int> biNu = List<int>.filled(2 * ((b58sz * 406 ~/ 555) + 1), 0);
    List<int> outi = List<int>.filled((b58sz + 3) >> 2, 0);

    for (int r in str.runes) {
      if (r > 127) {
        throw UnimplementedError('high-bit set on invalid digit');
      }
      if (alphabet.decode[r] == -1) {
        throw UnimplementedError('Invalid base58 digit${String.fromCharCode(r)}');
      }

      c = alphabet.decode[r];

      for (int j = outi.length - 1; j >= 0; j--) {
        if (support64) {
          t = outi[j] * 58 + c;
          c = t >> 32;
          outi[j] = t & 0xffffffff;
        } else {
          t = outi[j] * 58 + c;
          c = (outi[j] * 58 + c) ~/ 0xffffffff;
          outi[j] = t & 0xffffffff;
        }
      }
    }

    int mask = ((b58sz % 4) * 8) & 0xffffffff;
    if (mask == 0) {
      mask = 32;
    }
    mask = (mask - 8) & 0xffffffff;

    int outLen = 0;
    for (int j = 0; j < outi.length; j++) {
      for (; mask < 32;) {
        biNu[outLen] = (outi[j] >> mask) & 0xff;
        mask = (mask - 8) & 0xffffffff;
        outLen++;
      }
      mask = 24;
    }
    for (int msb = zCount; msb < biNu.length; msb++) {
      if (biNu[msb] > 0) {
        return biNu.sublist(msb - zCount, outLen);
      }
    }
    return biNu.sublist(0, outLen);
  }
}
