library aura_external_wallet;

import 'src/aura_external_wallet_impl.dart';
import 'src/core/type_data/aura_wallet_type_data.dart';
export 'src/core/exceptions/aura_external_exception.dart';

enum AuraExternalWalletEnvironment {
  mainNet,
  euphoria,
  testNet,
}

///
/// This type of wallet uses third-party wallet applications, such as C98 Wallet, Kepler Wallet, and others, to perform blockchain operations.
/// {@category ExternalWallet}
abstract class AuraExternalWallet {
  factory AuraExternalWallet.create(
    String appName,
    String appLogo,
    String urlCallBack, {
    AuraExternalWalletEnvironment environment =
        AuraExternalWalletEnvironment.testNet,
  }) {
    return AuraExternalWalletImpl(appName, appLogo, urlCallBack, environment);
  }

  Future<AuraWalletConnectionResult> connectWallet();

  Future<AuraConnectWalletInfoResult> requestAccountInfo();

  Future<String> sendTransaction({
    required String signer,
    required String toAddress,
    required String amount,
    required String fee,
    String? memo,
  });

  Future<String> executeContract({
    required String signer,
    required String contractAddress,
    required Map<String, dynamic> executeMessage,
    List<int>? funds,
    int? fee,
  });

  void dispose();
}
