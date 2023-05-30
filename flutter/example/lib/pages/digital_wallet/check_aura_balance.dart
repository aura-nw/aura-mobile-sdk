import 'package:aura_sdk/aura_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckHDWalletBalance extends StatefulWidget {
  const CheckHDWalletBalance({super.key});

  @override
  State<CheckHDWalletBalance> createState() => _CheckHDWalletBalanceState();
}

class _CheckHDWalletBalanceState extends State<CheckHDWalletBalance> {
  String walletBalance = '';
  TextEditingController addressController = TextEditingController();
  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Hd Wallet Balance'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Check Hd Wallet Balance'),
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
              controller: addressController,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                labelText: 'Enter Address',
                errorText: errorMsg,
                hintText: 'Address',
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: doCheck,
                child: const Text('Check'),
              )),
          Container(
            margin: const EdgeInsets.only(left: 16, top: 32),
            width: double.infinity,
            child: const Text('Wallet Amount'),
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
              onPressed: () {},
              child: Text(walletBalance),
            ),
          ),
        ]),
      ),
    );
  }

  void doCheck() async {
    String address = addressController.text;

    if (address.isEmpty) {
      setState(() {
        errorMsg = 'Please input address to check balance';
      });
      return;
    }
    errorMsg = null;
    final String balance =
        await AuraSDK.instance.inAppWallet.checkWalletBalance(address: address);
    setState(() {
      walletBalance = balance;
    });
  }

  void copyAddress() async {
    await Clipboard.setData(ClipboardData(text: walletBalance));
  }
}
