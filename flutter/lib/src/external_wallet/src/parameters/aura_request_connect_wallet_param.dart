import 'aura_wallet_core_param.dart';

class AuraConnectWalletOption {
  final String? appName;
  final String? dAppUrl;
  final String? logo;

  const AuraConnectWalletOption({
    required this.appName,
    this.dAppUrl,
    required this.logo,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': appName,
      'callbackURL': dAppUrl,
      'logo': logo,
    };
  }
}

class AuraRequestConnectWalletParam extends AuraWalletCoreParam {
  final List<AuraConnectWalletOption>? params;

  AuraRequestConnectWalletParam({
    this.params,
  }) : super(method: 'connect');

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();

    return json
      ..addAll({
        'params': params?.map((e) => e.toJson()).toList(),
      });
  }
}
