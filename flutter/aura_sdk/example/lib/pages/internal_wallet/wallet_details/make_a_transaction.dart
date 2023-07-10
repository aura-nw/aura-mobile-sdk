import 'package:aura_connect_sdk_example/pages/internal_wallet/widgets/loading_screen_mixin.dart';
import 'package:aura_sdk/aura_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/make_a_transaction/wallet_from_widget.dart';
import '../widgets/make_a_transaction/wallet_to_widget.dart';

class MakeTransactionPage extends StatefulWidget {
  final AuraWallet auraWallet;

  const MakeTransactionPage({required this.auraWallet, super.key});

  @override
  State<MakeTransactionPage> createState() => _MakeTransactionPageState();
}

class _MakeTransactionPageState extends State<MakeTransactionPage>
    with ScreenLoaderMixin {
  String address = '';
  double amount = 0;
  String? errorMsg = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      doGetWalletInfo();
    });
  }

  TransactionToWidgetController controller = TransactionToWidgetController(
      TextEditingController(
          text: 'aura1k24l7vcfz9e7p9ufhjs3tfnjxwu43h8quq4glv'));

  @override
  Widget builder(BuildContext context) {
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
            errorMsg == null
                ? TransactionFromWidget(address: address, amount: amount)
                : Container(
                    margin: const EdgeInsets.only(top: 32),
                    height: 50,
                    width: 100,
                    child: OutlinedButton(
                        onPressed: doGetWalletInfo, child: const Text('Get Info'))),
            if (errorMsg == null)
              TransactionToWidget(
                address: address,
                amount: amount,
                controller: controller,
              ),
            if (errorMsg == null)
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

  void doGetWalletInfo() async {
    if (!mounted) {
      return;
    }
    showLoading();
    errorMsg = null;
    try {
      final String amountStr = await widget.auraWallet.checkWalletBalance();
      double? amountData = double.tryParse(amountStr);
      setState(() {
        address = widget.auraWallet.wallet.bech32Address;
        amount = amountData ?? 0;
      });
    } catch (e) {
      errorMsg = e.toString();
    } finally {
      hideLoading();
    }
  }

  void doSend() async {
    showLoading();
    String toAddress = controller.textEditingController.text;
    int amount = (controller.amount * 1000000).toInt();

    final tx = await widget.auraWallet.makeTransaction(
        toAddress: toAddress, amount: amount.toString(), fee: '200');

    final response = await widget.auraWallet.submitTransaction(
      signedTransaction: tx,
    );

    if (response) {
      print("success");
    } else {
      print("fail");
    }
    hideLoading();
  }

  void copyAddress() async {
    await Clipboard.setData(ClipboardData(text: address));
  }
}
