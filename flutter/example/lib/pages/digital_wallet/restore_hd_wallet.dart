import 'package:aura_sdk/aura_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RestoreHdWalletPage extends StatefulWidget {
  const RestoreHdWalletPage({super.key});

  @override
  State<RestoreHdWalletPage> createState() => _RestoreHdWalletPageState();
}

class _RestoreHdWalletPageState extends State<RestoreHdWalletPage> {
  String address = '';
  TextEditingController passpharseController = TextEditingController();
  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restore Hd Wallet'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Restore HD Wallet'),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Colors.black,
            //     width: 1.0,
            //   ),
            // ),
            child: TextField(
              controller: passpharseController,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                labelText: 'Enter the passpharse',
                errorText: errorMsg,
                hintText: 'passpharse',
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: doRestoreWallet,
                child: const Text('Restore'),
              )),
          Container(
            margin: const EdgeInsets.only(left: 16, top: 32),
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
          ),
        ]),
      ),
    );
  }

  void doRestoreWallet() async {
    String? passpharse = passpharseController.text;

    try {
      final WalletInfo wallet =
          await AuraSDK.instance.inAppWallet.restoreHDWallet(
        mnemonic: passpharse,
      );
      setState(() {
        address = wallet.wallet.bech32Address;
        passpharse = wallet.mnemonic;
      });
    } catch (e) {
      print(e);
    }
  }

  void copyAddress() async {
    await Clipboard.setData(ClipboardData(text: address));
  }
}
