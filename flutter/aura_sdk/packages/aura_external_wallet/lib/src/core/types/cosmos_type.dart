import 'package:aura_external_wallet/src/core/types/uint53.dart';

class AminoMessage {
  final String urlType;
  final Map<String, dynamic>? value;

  const AminoMessage({
    required this.urlType,
    required this.value,
  });

  Map<String, dynamic> toAminoMessage() {
    return {
      'typeUrl': urlType,
      'value': value,
    };
  }
}

class Coin {
  final String amount;
  final String denom;

  Coin({
    required this.amount,
    required this.denom,
  }) {
    int? amountParse = int.tryParse(amount);
    if (amountParse == null) {
      throw UnimplementedError('Amount required type int.toString()');
    }
  }

  Map<String, dynamic> toCoin() {
    return {
      'amount': amount,
      'denom': denom,
    };
  }
}

class StdFee {
  final String gas;
  final List<Coin> coins;

  StdFee({
    this.gas = '130000',
    required this.coins,
  }) {
    int? gasParse = int.tryParse(gas);

    if (gasParse == null) {
      throw UnimplementedError('Gas required type int.toString()');
    }
  }

  Map<String, dynamic> toStdFee() {
    return {
      'gas': gas,
      'amount': coins
          .map(
            (e) => e.toCoin(),
          )
          .toList(),
    };
  }
}

class StdSignDoc {
  final String chainId;
  final String accountNumber;
  final String sequence;
  final StdFee fee;
  final List<AminoMessage> msgs;
  final String memo;

  const StdSignDoc({
    required this.fee,
    required this.chainId,
    this.memo = '',
    this.sequence = '',
    this.accountNumber = '',
    required this.msgs,
  });

  factory StdSignDoc.makeSignDoc({
    required List<AminoMessage> msgs,
    required StdFee fee,
    required String chainId,
    required String memo,
    required String accountNumber,
    required String sequence,
  }) {
    return StdSignDoc(
        fee: fee,
        chainId: chainId,
        msgs: msgs,
        memo: memo,
        accountNumber: Uint53.fromString(accountNumber).toString(),
        sequence: Uint53.fromString(sequence).toString());
  }

  Map<String, dynamic> toSignDoc() {
    return {
      'chain_id': chainId,
      'account_number': accountNumber,
      'sequence': sequence,
      'fee': fee.toStdFee(),
      'memo': memo,
      'msgs': msgs
          .map(
            (e) => e.toAminoMessage(),
          )
          .toList(),
    };
  }
}
