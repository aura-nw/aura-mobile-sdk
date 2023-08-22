import 'dart:convert';
import 'dart:developer';

import 'widgets/loading_screen_mixin.dart';
import 'package:aura_sdk/aura_sdk.dart';
import 'package:flutter/material.dart';

class ExecuteContractPage extends StatefulWidget {
  final AuraConnectWalletInfoResult account;

  const ExecuteContractPage({required this.account, super.key});

  @override
  State<ExecuteContractPage> createState() => _ExecuteContractPageState();
}

class _ExecuteContractPageState extends State<ExecuteContractPage>
    with ScreenLoaderMixin {
  String address = '';
  String? errorMsg = "";

  @override
  void initState() {
    super.initState();

    _triggerController.text = 'transfer';

    _parameterController.text = '{"amount" : "200","recipient": "aura1yukgemvxtr8fv6899ntd65qfyhwgx25d2nhvj6"}';
  }

  final TextEditingController _contractAddress = TextEditingController(
    text: 'aura1h3kn034nh4p8gwnuqya80rdhyvg3h775ukwul49qsugzk7v3qprs2nhgzh',
  );
  final TextEditingController _triggerController = TextEditingController();
  final TextEditingController _parameterController = TextEditingController();

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
                controller: _contractAddress,
                decoration: const InputDecoration(
                  hintText: 'Contract address',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _triggerController,
                decoration: const InputDecoration(
                  hintText: 'Input Trigger',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _parameterController,
                decoration: const InputDecoration(
                  hintText: 'Input Param',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 32),
                height: 50,
                width: 100,
                child: OutlinedButton(
                  onPressed: () async {
                    try {
                      showLoading();

                      final Map<String,dynamic> executeMessage = jsonDecode(_parameterController.text.trim());

                      await AuraSDK.instance.externalWallet.executeContract(
                          signer: widget.account.data.be32Address,
                          contractAddress:
                              _contractAddress.text.trim(),
                          executeMessage: {
                            _triggerController.text.trim(): executeMessage,
                          }).then(
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
                  child: const Text('Execute'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
