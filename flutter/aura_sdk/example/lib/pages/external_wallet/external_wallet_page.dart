import 'dart:developer';
import 'package:aura_sdk/aura_sdk.dart';
import 'package:flutter/material.dart';

class ExternalWalletPage extends StatefulWidget {
  const ExternalWalletPage({super.key, required this.title});

  final String title;

  @override
  State<ExternalWalletPage> createState() => _ExternalWalletPageState();
}

class _ExternalWalletPageState extends State<ExternalWalletPage> {

  bool isConnect = false;

  AuraConnectWalletInfoResult ?account;

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
            if(isConnect) ...[
              SizedBox(
                width: 200,
                child: OutlinedButton(
                  onPressed: () async {
                    try{
                      account = await AuraSDK.instance.externalWallet.requestAccountInfo();
                    }catch(e){
                      log('Received Error ${e.toString()}');
                    }
                  },
                  child: const Text('Get Account Info'),
                ),
              ),
              SizedBox(
                width: 200,
                child: OutlinedButton(
                  onPressed: () async {
                    if(account!=null){
                      Navigator.pushNamed(context, '/external-wallet/sign-and-broadcast',arguments: account);
                    }
                  },
                  child: const Text('Make transaction'),
                ),
              ),
              SizedBox(
                width: 200,
                child: OutlinedButton(
                  onPressed: () async {
                    if(account!=null){
                      Navigator.pushNamed(context, '/external-wallet/execute-contract',arguments: account);
                    }
                  },
                  child: const Text('Execute smart contract'),
                ),
              ),
            ] else SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: () {
                  try {
                    AuraSDK.instance.externalWallet
                        .connectWallet()
                        .then((value) {
                      isConnect = value.result;

                      setState(() {

                      });
                    });
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: const Text('Connect C98'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
