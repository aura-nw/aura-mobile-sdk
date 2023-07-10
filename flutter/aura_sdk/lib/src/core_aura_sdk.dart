import 'package:aura_external_wallet/aura_external_wallet.dart';
import 'package:aura_internal_wallet/aura_internal_wallet.dart';
export 'package:aura_sdk/src/cores/errors/sdk_error.dart';

enum AuraWalletEnvironment {
  mainNet,
  euphoria,
  testNet,
}

extension AuraWalletEnvironmentMapper on AuraWalletEnvironment {
  AuraExternalWalletEnvironment get toExternal {
    switch (this) {
      case AuraWalletEnvironment.mainNet:
        return AuraExternalWalletEnvironment.mainNet;
      case AuraWalletEnvironment.euphoria:
        return AuraExternalWalletEnvironment.euphoria;
      case AuraWalletEnvironment.testNet:
        return AuraExternalWalletEnvironment.testNet;
    }
  }

  AuraInternalWalletEnvironment get toInternal {
    switch (this) {
      case AuraWalletEnvironment.mainNet:
        return AuraInternalWalletEnvironment.mainNet;
      case AuraWalletEnvironment.euphoria:
        return AuraInternalWalletEnvironment.euphoria;
      case AuraWalletEnvironment.testNet:
        return AuraInternalWalletEnvironment.testNet;
    }
  }
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
  AuraInAppWallet get inAppWallet;

  /// External wallet requires users to install and use a third-party wallet application on their device.
  AuraExternalWallet get externalWallet;

  void dispose();
}

class _AuraSDKImpl extends AuraSDK {
  final String appName;
  final String appLogo;
  final String callBackUrl;
  final AuraWalletEnvironment environment;

  late final AuraInAppWallet _inAppWallet;
  late final AuraExternalWallet _externalWallet;

  _AuraSDKImpl(this.appName,
      this.appLogo,
      this.callBackUrl,
      this.environment,) {
    _inAppWallet = AuraInAppWallet.create(
      environment: environment.toInternal,
    );
    _externalWallet = AuraExternalWallet.create(
      appName,
      appLogo,
      callBackUrl,
      environment: environment.toExternal,
    );
  }

  @override
  AuraInAppWallet get inAppWallet => _inAppWallet;

  @override
  AuraExternalWallet get externalWallet => _externalWallet;

  @override
  void dispose() {
    // _inAppWallet.
    _externalWallet.dispose();
  }
}
