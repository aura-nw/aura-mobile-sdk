import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:aura_wallet/app_configs/aura_wallet_config.dart';
import 'package:aura_wallet/aura_wallet.dart';

class AuraWalletProductionConfig implements AuraWalletConfig {
  AuraWalletProductionConfig({
    required this.baseUrl,
    this.configs,
    this.environment = Environment.production,
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

  final AuraWalletConfig config = AuraWalletProductionConfig(
    baseUrl: dotenv.env.baseUrl,
    configs: dotenv.env.configs,
  );

  start(config);
}
