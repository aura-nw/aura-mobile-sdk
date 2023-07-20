import 'dart:developer';
import 'dart:typed_data';

import 'package:aura_sdk/aura_sdk.dart';
import 'package:flutter/material.dart';

class ExternalWalletPage extends StatefulWidget {
  const ExternalWalletPage({super.key, required this.title});

  final String title;

  @override
  State<ExternalWalletPage> createState() => _ExternalWalletPageState();
}

class _ExternalWalletPageState extends State<ExternalWalletPage> {
  Uint8List? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: () {
                  try {
                    AuraSDK.instance.externalWallet
                        .connectWallet()
                        .then((value) {
                      print(value.result);
                    });
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: const Text('Connect C98'),
              ),
            ),
            SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: () {
                  AuraSDK.instance.externalWallet.requestAccountInfo();
                },
                child: const Text('Get Account Info'),
              ),
            ),
            SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Check balance'),
              ),
            ),
            SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: () async {
                  try {
                    if (data != null) {
                      await AuraSDK.instance.externalWallet
                          .broadcastTransaction(
                        bytes: data!,
                        signer: 'aura18dftkv07h76uhmxjkrp8da4ezlsdql5sudtuxn',
                      );
                      return;
                    }
                    data =
                        await AuraSDK.instance.externalWallet.signTransaction(
                      signer: 'aura18dftkv07h76uhmxjkrp8da4ezlsdql5sudtuxn',
                      toAddress: 'aura176wt9d8zdg0dgrtvzxvplgdmv99j5yn3enpedl',
                      amount: '5000',
                      fee: '1000',
                      memo: 'Auto memo for Dev',
                    );
                  } catch (e) {
                    log('Received Error ${e.toString()}');
                  }
                },
                child: const Text('Make transaction'),
              ),
            ),
            SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: () async {
                  try {
                    final hash =
                        await AuraSDK.instance.externalWallet.executeContract(
                      signer: 'aura176wt9d8zdg0dgrtvzxvplgdmv99j5yn3enpedl',
                      contractAddress:
                          'aura1h3kn034nh4p8gwnuqya80rdhyvg3h775ukwul49qsugzk7v3qprs2nhgzh',
                      executeMessage: {
                        'transfer': {
                          'amount': '250',
                          'recipient':
                              'aura1yukgemvxtr8fv6899ntd65qfyhwgx25d2nhvj6',
                        },
                      },
                    );

                    log('Received Hash = $hash');
                  } catch (e) {
                    log('Received Error ${e.toString()}');
                  }
                },
                child: const Text('Execute smart contract'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
