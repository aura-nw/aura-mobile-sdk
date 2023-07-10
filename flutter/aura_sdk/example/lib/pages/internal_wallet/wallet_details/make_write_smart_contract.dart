import 'dart:convert';

import 'package:aura_connect_sdk_example/pages/internal_wallet/widgets/loading_screen_mixin.dart';
import 'package:aura_sdk/aura_sdk.dart';
import 'package:flutter/material.dart';

class MakeWriteSmartContract extends StatefulWidget {
  final AuraWallet auraWallet;
  const MakeWriteSmartContract({required this.auraWallet,Key? key}) : super(key: key);

  @override
  State<MakeWriteSmartContract> createState() => _MakeWriteSmartContractState();
}

class _MakeWriteSmartContractState extends State<MakeWriteSmartContract>
    with ScreenLoaderMixin {

  final TextEditingController _contractAddressController =
  TextEditingController();
  final TextEditingController _triggerController = TextEditingController();
  final TextEditingController _parameterController = TextEditingController();

  static const String contractAddress =
      'aura1h3kn034nh4p8gwnuqya80rdhyvg3h775ukwul49qsugzk7v3qprs2nhgzh';

  String hash = '';

  @override
  void initState() {
    super.initState();
    _contractAddressController.text = contractAddress;
    _triggerController.text = 'transfer';

    _parameterController.text = '{"amount" : "200","recipient": "aura1yukgemvxtr8fv6899ntd65qfyhwgx25d2nhvj6"}';
  }

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Write smart contract'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Column(
            children: [
                Text(
                    'Wallet Address: ${widget.auraWallet.wallet.bech32Address}'),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _contractAddressController,
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
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  if(_triggerController.text.isEmpty) return;

                  showLoading();

                  Map<String,dynamic> param = jsonDecode(_parameterController.text.trim());

                  Map<String,dynamic> executeMessage = {
                    _triggerController.text.trim() : param,
                  };

                  print(executeMessage);


                  await widget.auraWallet.makeInteractiveWriteSmartContract(
                    contractAddress: contractAddress,
                    executeMessage: executeMessage,
                    funds: [
                      200,
                    ],
                  ).then((value) {
                    hash = value;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const Dialog(
                          child: SizedBox(
                            height: 100,
                            child: Center(
                              child: Text('Success!!!!!!'),
                            ),
                          ),
                        );
                      },
                    );
                  }).onError((error, stackTrace) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: SizedBox(
                            height: 100,
                            child: Center(
                              child: Text(error.toString()),
                            ),
                          ),
                        );
                      },
                    );
                  }).whenComplete(
                    () => hideLoading(),
                  );
                },
                child: const Text('Trigger'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {

                  showLoading();
                  try {
                    await widget.auraWallet.verifyTxHash(txHash: hash).then((isSuccess) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: SizedBox(
                              height: 100,
                              child: Center(
                                child: isSuccess ? const Text('Success!!!!!!') : const Text('Error!!!!!'),
                              ),
                            ),
                          );
                        },
                      );
                    });
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: SizedBox(
                            height: 100,
                            child: Center(
                              child: Text(e.toString()),
                            ),
                          ),
                        );
                      },
                    );
                  } finally {
                    hideLoading();
                  }
                },
                child: const Text('Verify hash'),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
