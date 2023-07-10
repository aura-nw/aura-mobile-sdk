import 'package:aura_wallet/src/core/utils/dart_core_extension.dart';

class AuraWalletBalanceData {
  final List<AuraWalletBalance> balances;

  const AuraWalletBalanceData({required this.balances});
}

class AuraWalletBalance {
  final String id;
  final String deNom;
  final String amount;

  const AuraWalletBalance({
    required this.id,
    required this.amount,
    required this.deNom,
  });

  String get toAura {
    double amount = double.tryParse(this.amount) ?? 0;
    switch (deNom.toUpperCase()) {
      case 'AURA':
        return '${amount.truncateToDecimalPlaces(2)} AURA';
      case 'UEAURA':
        return '${(amount / 1000000).truncateToDecimalPlaces(2)} EAURA';
      case 'UAURA':
        return '${(amount / 1000000).truncateToDecimalPlaces(2)} AURA';
      default:
        return '${amount.truncateToDecimalPlaces(2)} AURA';
    }
  }
}
