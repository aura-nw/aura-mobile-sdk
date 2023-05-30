import 'package:aura_sdk/src/inapp_wallet/inapp_wallet.dart';
import 'package:aura_sdk/src/external_wallet/external_wallet.dart';
import 'package:aura_sdk/src/inapp_wallet/inapp_wallet_impl.dart';

import 'core/aura_sdk_implement.dart';

export 'inapp_wallet/inapp_wallet.dart';
export 'external_wallet/external_wallet.dart';

enum AuraWalletEnvironment {
  mainNet,
  testNet,
}

///
/// The Core SDK is responsible for the bulk of functionality that is available on the Immutable platform. It can be used with the Wallet SDK in order to establish a connection with users' wallets to sign certain transactions that require users' approval.
///
/// {@macro template_name}
/// More comments
abstract class AuraSDK {
  static AuraSDK? _instance;

  /// The instance of AuraSDK
  static AuraSDK get instance {
    // Not if there is nothing before it.
    if (_instance == null) {
      throw 'Have to call AuraSDK.init first';
    }
    return _instance!;
  }

  /// Init the AuraSDK with [appName], [appLogo], [urlCallBack]
  static AuraSDK init(String appName, String appLogo, String urlCallBack,
      {AuraWalletEnvironment environment = AuraWalletEnvironment.testNet}) {
    _instance = _AuraSDKImpl(appName, appLogo, urlCallBack, environment);
    return _instance!;
  }

  /// An in-app wallet allows users to have direct control over their funds within the application itself.
  InAppWallet get inAppWallet;

  /// External wallet requires users to install and use a third-party wallet application on their device.
  ExternalWallet get externalWallet;

  void dispose();
}

class _AuraSDKImpl extends AuraSDK {
  final String appName;
  final String appLogo;
  final String callBackUrl;
  final AuraWalletEnvironment environment;

  late final InAppWallet _inAppWallet;
  late final ExternalWallet _externalWallet;

  _AuraSDKImpl(
    this.appName,
    this.appLogo,
    this.callBackUrl,
    this.environment,
  ) {
    _inAppWallet = InAppWalletImpl();
    _externalWallet = ExternalWalletImpl(appName, appLogo, callBackUrl);
  }

  @override
  InAppWallet get inAppWallet => _inAppWallet;

  @override
  ExternalWallet get externalWallet => _externalWallet;

  @override
  void dispose() {
    // _inAppWallet.
    _externalWallet.dispose();
  }
}
