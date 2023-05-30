import 'dart:async';

import 'package:aura_sdk/aura_sdk.dart';
import 'package:flutter/material.dart';

import 'pages/digital_wallet/check_aura_balance.dart';
import 'pages/digital_wallet/create_hd_wallet.dart';
import 'pages/digital_wallet/digital_wallet_page.dart';
import 'pages/digital_wallet/make_a_transaction.dart';
import 'pages/digital_wallet/restore_hd_wallet.dart';
import 'pages/digital_wallet/transaction_history.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final AuraConnectSdk _connectSdk = AuraConnectSdk();
  late final AuraSDK auraSDK;

  @override
  void initState() {
    auraSDK = AuraSDK.init(
        environment: AuraWalletEnvironment.testNet,
        "Aura Dapp",
        "https://pbs.twimg.com/profile_images/1623175385402986497/pfm8dHoo_400x400.jpg",
        "app://open.my.app");
    super.initState();
  }

  @override
  void dispose() {
    auraSDK.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/digital-wallet': (_) =>
            const InAppWalletPage(title: 'Digital Wallet Demo'),
        '/generate-hd-wallet': (_) => const CreateHdWalletPage(),
        '/restore-hd-wallet': (_) => const RestoreHdWalletPage(),
        '/check-hd-wallet-balance': (_) => const CheckHDWalletBalance(),
        '/make-transaction': (_) => const MakeTransactionPage(),
        // '/transaction-history': (_) => const TransactionHistory(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // AuraWalletInfoData? data;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: SizedBox(
        width: 400,
        height: 800,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton(
              onPressed: () async {
                //Navigator.of(context).pushNamed('/digital-wallet');
                // auraSDK.;

                // await _connectSdk.connectWallet().then((connection) {
                //   print(connection.result);
                // }).catchError((error) {
                //   print('error --$error');
                // });
              },
              child: const Text('Open'),
            ),
            ElevatedButton(
              onPressed: () async {
                // await _connectSdk.requestAccessWallet().then((walletData) {
                //   setState(() {
                //     data = walletData;
                //   });
                // }).catchError((error) {
                //   print('request access Wallet error ${error}');
                // });
              },
              child: const Text('Get account'),
            ),
            ElevatedButton(
              onPressed: () async {
                // final addressWallet = await _connectSdk.transfer( param: TransferParam(params: params),
                //   fromId: '',
                //   toId: '',
                //   gas: '100',
                //   gasPrice: '100',
                //   value: '100',
                //   data: '100',
                //   nonce: '100',
                // );
              },
              child: const Text('Transfer'),
            ),
            const SizedBox(
              height: 40,
            ),

            ElevatedButton(
              onPressed: () async {
                final data = await AuraSDK.instance.inAppWallet
                    .makeInteractiveQuerySmartContract(
                  contractAddress:
                      'aura1qye5hls3tnttxfhaa2klftrqcevcz02a4uzzy568nm5cgkqfvflqpu7plx',
                  query: {
                    'owner_of': {'token_id': '2'}
                  },
                );

                print(data);
              },
              child: const Text('Query smart contract'),
            ),
            const SizedBox(
              height: 40,
            ),

            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                final wallet = await AuraSDK.instance.inAppWallet.restoreHDWallet(
                    mnemonic:
                        'nation vacuum size learn apology regular industry final head suit nasty detail');

                final data = await AuraSDK.instance.inAppWallet
                    .makeInteractiveWriteSmartContract(
                  contractAddress:
                      'aura1c0s4p3lf87c5x3u4zgqfvamkqrl47ucxcyfudfzauwtg5g3ra3lsv0tnzd',
                  executeMessage: {
                    'mint': {
                      'amount': '1200',
                      'recipient': 'aura176wt9d8zdg0dgrtvzxvplgdmv99j5yn3enpedl'
                    },
                  },
                  fee: 250,
                  wallet: wallet.wallet,
                );

                setState(() {
                  isLoading = false;
                });

                print(data);
              },
              child: const Text('Execute smart contract'),
            ),
            const SizedBox(
              height: 40,
            ),
            if (isLoading) const Text('Loading...'),
            // if (data != null) ...[
            //   Text('address : ${data!.data.address}'),
            //   Text('name : ${data!.data.name}'),
            // ]
          ],
        ),
      ),
    );
  }
}
