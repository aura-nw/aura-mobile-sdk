import 'package:aura_wallet/src/application/wrappers/localization/localization_manager.dart';

import 'app_configs/aura_wallet_config.dart';
import 'package:aura_wallet/src/aura_wallet_application.dart';
import 'package:flutter/material.dart';
import 'app_configs/di.dart' as di;
import 'package:aura_sdk/aura_sdk.dart';

void start(AuraWalletConfig config) async {
  await AppLocalizationManager.instance.load();

  AuraSDK.init(
    'Aura Wallet',
    'Null',
    'Null',
    environment: config.environment == Environment.dev
        ? AuraWalletEnvironment.testNet
        : config.environment == Environment.staging
            ? AuraWalletEnvironment.euphoria
            : AuraWalletEnvironment.mainNet,
  );
  await di.initDependency(config);

  runApp(const AuraWalletApplication());
}