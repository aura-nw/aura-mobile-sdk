import 'package:flutter/material.dart';

class InAppWalletPage extends StatefulWidget {
  const InAppWalletPage({super.key, required this.title});
  final String title;

  @override
  State<InAppWalletPage> createState() => _InAppWalletPageState();
}

class _InAppWalletPageState extends State<InAppWalletPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
                onPressed: () =>
                    Navigator.of(context).pushNamed('/generate-hd-wallet'),
                child: const Text('Create Wallet'),
              ),
            ),
            SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/restore-hd-wallet'),
                child: const Text('Restore'),
              ),
            ),
            SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/check-hd-wallet-balance'),
                child: const Text('Check balance'),
              ),
            ),
            SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/make-transaction'),
                child: const Text('Make transaction'),
              ),
            ),
            SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/transaction-history'),
                child: const Text('Transaction History'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
