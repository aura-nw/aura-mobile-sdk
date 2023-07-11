import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:aura_wallet_example/app_configs/aura_wallet_config.dart';
import 'package:aura_wallet_example/aura_wallet.dart';

class AuraWalletStagingConfig implements AuraWalletConfig {
  AuraWalletStagingConfig({
    required this.baseUrl,
    this.configs,
    this.environment = Environment.staging,
  });

  @override
  String baseUrl;

  @override
  Map<String, dynamic>? configs;

  @override
  Environment environment;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/.env');

  final AuraWalletConfig config = AuraWalletStagingConfig(
    baseUrl: dotenv.env.baseUrl,
    configs: dotenv.env.configs,
  );

  start(config);
}
