import 'package:aura_wallet/src/core/constants/transaction_enum.dart';
import 'package:aura_wallet/src/core/utils/dart_core_extension.dart';

class AuraTransaction {
  final String id;
  final AuraTxData txData;

  const AuraTransaction({required this.id, required this.txData});

  bool get status => txData.code == "0";

  bool get isMsgSend => type == TransactionTypeValue.Send;

  bool get isMsgReceived => type == TransactionTypeValue.Received;

  String get type {
    List<AuraTxMessage> messages = txData.tx.body.messages;

    if (messages.isEmpty) return '';

    String mType = message!.type;

    if (messages.length > 1) {
      for (final message in messages) {
        if (message.type != TransactionType.IBCUpdateClient &&
            message.type.contains('ibc')) {
          mType = message.type;

          break;
        }
      }
    }

    return TYPE_TRANSACTION_MAP[mType] ?? 'TBD';
  }

  String get fee {
    final amount = txData.tx.authInfo.fee.amounts.firstOrNull;

    if (amount == null) return '';

    double price = (int.tryParse(amount.amount) ?? 0).toDouble();

    switch (amount.deNom.toUpperCase()) {
      case 'AURA':
        return '${price.truncateToDecimalPlaces(5)} AURA';
      case 'UEAURA':
        return '${(price / 1000000).truncateToDecimalPlaces(5)} EAURA';
      case 'UAURA':
        return '${(price / 1000000).truncateToDecimalPlaces(5)} AURA';
      default:
        return '${price.truncateToDecimalPlaces(5)} AURA';
    }
  }

  String get amount {
    List<AuraTxMessage> messages = txData.tx.body.messages;

    if (messages.isEmpty) return '';

    String mType = message!.type;

    if (message != null && mType == TransactionType.Send) {

      final amount = message?.amount?.firstOrNull;

      if(amount == null) return '';

      double price = (int.tryParse(amount.amount) ?? 0).toDouble();

      switch (amount.deNom.toUpperCase()) {
        case 'AURA':
          return '${price.truncateToDecimalPlaces(6)} AURA';
        case 'UEAURA':
          return '${(price / 1000000).truncateToDecimalPlaces(6)} EAURA';
        case 'UAURA':
          return '${(price / 1000000).truncateToDecimalPlaces(6)} AURA';
        default:
          return '${price.truncateToDecimalPlaces(6)} AURA';
      }
    } else {
      return '';
    }
  }

  AuraTxMessage? get message => txData.tx.body.messages.firstOrNull;
}

class AuraTxData {
  final double height;
  final String txHash;
  final String code;
  final String timeStamp;
  final AuraTx tx;

  const AuraTxData({
    required this.height,
    required this.timeStamp,
    required this.code,
    required this.txHash,
    required this.tx,
  });
}

class AuraTx {
  final AuraTxBody body;
  final AuraTxAuthInfo authInfo;

  const AuraTx({
    required this.body,
    required this.authInfo,
  });
}

class AuraTxBody {
  final String memo;
  final List<AuraTxMessage> messages;

  const AuraTxBody({required this.messages, required this.memo});
}

class AuraTxMessage {
  final String type;
  final String? grantee;
  final List<AuraTxAmount>? amount;

  const AuraTxMessage({
    required this.type,
    this.grantee,
    this.amount,
  });
}

class AuraTxAmount {
  final String deNom;
  final String amount;

  const AuraTxAmount({
    required this.amount,
    required this.deNom,
  });
}

class AuraTxAuthInfo {
  final AuraTxAuthInfoFee fee;

  const AuraTxAuthInfo({required this.fee});
}

class AuraTxAuthInfoFee {
  final List<AuraTxAmount> amounts;

  const AuraTxAuthInfoFee({
    required this.amounts,
  });
}
