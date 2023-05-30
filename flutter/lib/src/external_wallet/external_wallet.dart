import '../core/aura_sdk_implement.dart';

///
/// This type of wallet uses third-party wallet applications, such as C98 Wallet, Kepler Wallet, and others, to perform blockchain operations.
/// {@category ExternalWallet}
abstract class ExternalWallet {
  static ExternalWallet init(
      String appName, String appLogo, String urlCallBack) {
    return ExternalWalletImpl(appName, appLogo, urlCallBack);
  }

  Future connectWallet();
  Future requestAccountInfo();
  Future sendTransaction(String fromAddress, String toAddress);
  Future signContract(String contractAddress);

  void dispose();
}
