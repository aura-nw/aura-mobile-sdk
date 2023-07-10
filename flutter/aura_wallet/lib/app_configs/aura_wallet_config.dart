import 'dart:convert';

extension AuraWalletConfigX on Map<String, dynamic> {
  String get baseUrl => this['BASE_URL'];

  Map<String, dynamic> get configs => jsonDecode(this['APP_CONFIG']);

  String get horoScopeUrl => this['horoScope'];

  String get coinId => this['coinId'];
  String get chainId => this['chainId'];
  String get apiVersion => this['api_version'];
  String get deNom => this['denom'];
  String get symbol => this['coin'];
}

enum Environment {
  dev,
  staging,
  production,
}

abstract class AuraWalletConfig {
  late Environment environment;
  late String baseUrl;
  late Map<String, dynamic>? configs;
}
