import 'package:aura_sdk/aura_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/make_a_transaction/wallet_from_widget.dart';
import 'widgets/make_a_transaction/wallet_to_widget.dart';

class MakeTransactionPage extends StatefulWidget {
  const MakeTransactionPage({super.key});

  @override
  State<MakeTransactionPage> createState() => _MakeTransactionPageState();
}

class _MakeTransactionPageState extends State<MakeTransactionPage> {
  String address = '';
  double amount = 0;
  TextEditingController passpharseController = TextEditingController(
      text:
          'spawn raw crazy cross crash water author theme cheese document treat lunch');
  String? errorMsg;
  WalletInfo? seletectWalletInfo;

  TransactionToWidgetController controller = TransactionToWidgetController(
      TextEditingController(
          text: 'aura1k24l7vcfz9e7p9ufhjs3tfnjxwu43h8quq4glv'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Transaction Hd Wallet'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Make Transaction HD Wallet'),
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
                  labelText: 'passpharse',
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
                  child: const Text('Get Wallet Amount'),
                )),
            if (seletectWalletInfo != null)
              TransactionFromWidget(address: address, amount: amount),
            if (seletectWalletInfo != null)
              TransactionToWidget(
                address: address,
                amount: amount,
                controller: controller,
              ),
            if (seletectWalletInfo != null)
              Container(
                  margin: const EdgeInsets.only(top: 32),
                  height: 50,
                  width: 100,
                  child: OutlinedButton(
                      onPressed: doSend, child: const Text('Send'))),
          ]),
        ),
      ),
    );
  }

  void doRestoreWallet() async {
    String? passpharse = passpharseController.text;
    errorMsg = null;
    try {
      final WalletInfo wallet =
          await AuraSDK.instance.inAppWallet.restoreHDWallet(
        mnemonic: passpharse,
      );
      seletectWalletInfo = wallet;
      final String amountStr = await AuraSDK.instance.inAppWallet
          .checkWalletBalance(address: wallet.wallet.bech32Address);
      double? amountData = double.tryParse(amountStr);
      setState(() {
        address = wallet.wallet.bech32Address;
        amount = amountData ?? 0;
      });
    } catch (e) {
      print(e);
    }
  }

  void doSend() async {
    String toAddress = controller.textEditingController.text;
    int amount = (controller.amount * 1000000).toInt();

    final transaction = await AuraSDK.instance.inAppWallet.makeTransaction(
        wallet: seletectWalletInfo!.wallet,
        toAddress: toAddress,
        amount: amount.toString(),
        fee: '200');

    final response = await AuraSDK.instance.inAppWallet
        .submitTransaction(signedTransaction: transaction);

    if (response) {
      print("success");
    } else {
      print("fail");
    }
  }

  void copyAddress() async {
    await Clipboard.setData(ClipboardData(text: address));
  }
}
