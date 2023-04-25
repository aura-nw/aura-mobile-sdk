import 'aura_wallet_core_param.dart';

class AuraRequestAccessWalletParam extends AuraWalletCoreParam {
  final List<String>? params;

  AuraRequestAccessWalletParam({
    this.params,
  }) : super(method: 'cosmos_getKey');

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = super.toJson();

    json['params'] = params;

    return json;
  }
}
