import 'package:alan/alan.dart';

///
///
/// The WalletInfo class is responsible for managing the wallet information of a user. It contains the following properties:
///
/// wallet: Represents the user's wallet. It is an instance of the Wallet class.
///
/// mnemonic: Represents the mnemonic associated with the wallet.
///
/// {@subCategory InAppWallet}

class WalletInfo {
  final Wallet wallet;
  final String mnemonic;

  /// {@subCategory InAppWallet}
  WalletInfo(this.wallet, this.mnemonic);
}
