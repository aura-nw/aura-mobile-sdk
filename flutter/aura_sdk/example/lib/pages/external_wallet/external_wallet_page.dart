import 'package:flutter/material.dart';

class ExternalWalletPage extends StatefulWidget {
  const ExternalWalletPage({super.key, required this.title});
  final String title;

  @override
  State<ExternalWalletPage> createState() => _ExternalWalletPageState();
}

class _ExternalWalletPageState extends State<ExternalWalletPage> {
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
                onPressed: () {},
                child: const Text('Connect C98'),
              ),
            ),
            SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: () {},
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
                onPressed: () {},
                child: const Text('Make transaction'),
              ),
            ),
            SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Transaction History'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
