import 'dart:developer';

import 'widgets/loading_screen_mixin.dart';
import 'package:aura_sdk/aura_sdk.dart';
import 'package:flutter/material.dart';

class SignAndBroadCastTransaction extends StatefulWidget {
  final AuraConnectWalletInfoResult account;

  const SignAndBroadCastTransaction({required this.account, super.key});

  @override
  State<SignAndBroadCastTransaction> createState() =>
      _SignAndBroadCastTransactionState();
}

class _SignAndBroadCastTransactionState
    extends State<SignAndBroadCastTransaction> with ScreenLoaderMixin {
  String address = '';
  String? errorMsg = "";

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _toAddress = TextEditingController(
    text: 'aura176wt9d8zdg0dgrtvzxvplgdmv99j5yn3enpedl',
  );
  final TextEditingController _amount = TextEditingController(
    text: '5000',
  );
  final TextEditingController _fee = TextEditingController(
    text: '1000',
  );

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Transaction Hd Wallet'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Make Transaction HD Wallet'),
              ),
              TextField(
                controller: _toAddress,
                decoration: const InputDecoration(hintText: 'To address'),
              ),
              TextField(
                controller: _amount,
                decoration: const InputDecoration(hintText: 'Amount'),
              ),
              TextField(
                controller: _fee,
                decoration: const InputDecoration(hintText: 'Fee'),
              ),
              Container(
                margin: const EdgeInsets.only(top: 32),
                height: 50,
                width: 100,
                child: OutlinedButton(
                  onPressed: () async {
                    showLoading();
                    try {
                      await AuraSDK.instance.externalWallet
                          .signAndBroadcast(
                        signer: widget.account.data.be32Address,
                        toAddress: _toAddress.text.trim(),
                        amount: _amount.text.trim(),
                        fee: _fee.text.trim(),
                        memo: 'Test',
                      )
                          .then(
                        (hash) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: SizedBox(
                                  height: 250,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Hash = $hash'),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } catch (e) {
                      log('Received Error ${e.toString()}');
                    }finally{
                      hideLoading();
                    }
                  },
                  child: const Text('Send'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
