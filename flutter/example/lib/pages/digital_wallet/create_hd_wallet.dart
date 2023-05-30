import 'package:aura_sdk/aura_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateHdWalletPage extends StatefulWidget {
  const CreateHdWalletPage({super.key});

  @override
  State<CreateHdWalletPage> createState() => _CreateHdWalletPageState();
}

class _CreateHdWalletPageState extends State<CreateHdWalletPage> {
  String passpharse = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Hd Wallet'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Generate HD Wallet'),
          ),
          SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: doGeneWallet,
                child: const Text('Generate'),
              )),
          Container(
            margin: const EdgeInsets.only(left: 16, top: 16),
            width: double.infinity,
            child: const Text('PassPharse'),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              left: 16,
              top: 4,
              right: 16,
            ),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(8),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: copyPassPharse,
              child: Text(passpharse),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, top: 16),
            width: double.infinity,
            child: const Text('Address'),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              left: 16,
              top: 4,
              right: 16,
            ),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(8),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: copyAddress,
              child: Text(address),
            ),
          )
        ]),
      ),
    );
  }

  void doGeneWallet() async {
    final WalletInfo wallet =
        await AuraSDK.instance.inAppWallet.createRandomHDWallet();
    setState(() {
      address = wallet.wallet.bech32Address;
      passpharse = wallet.mnemonic;
    });
  }

  void copyPassPharse() async {
    await Clipboard.setData(ClipboardData(text: passpharse));
  }

  void copyAddress() async {
    await Clipboard.setData(ClipboardData(text: address));
  }
}
