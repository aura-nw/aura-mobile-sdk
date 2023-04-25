import 'aura_wallet_core_param.dart';

class SendTransaction {
  final String fromId;
  final String toId;
  final String gas;
  final String gasPrice;
  final String value;
  final String data;
  final String nonce;

  const SendTransaction({
    required this.value,
    required this.data,
    required this.fromId,
    required this.gas,
    required this.gasPrice,
    required this.nonce,
    required this.toId,
  });

  Map<String, dynamic> toJson() {
    return {
      'from': fromId,
      'to': toId,
      'gas': gas,
      'gasPrice': gasPrice,
      'value': value,
      'data': data,
      'nonce': nonce,
    };
  }
}

class TransferParam extends AuraWalletCoreParam {
  final List<SendTransaction> params;

  TransferParam({
    required this.params,
  }) : super(
          method: 'eth_sendTransaction',
        );

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = super.toJson();

    json['params'] = params.map((e) => e.toJson()).toList();
    return json;
  }
}
