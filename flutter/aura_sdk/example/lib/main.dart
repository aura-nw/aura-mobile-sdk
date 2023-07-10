import 'pages/internal_wallet/wallet_details/transaction_history.dart';
import 'pages/internal_wallet/wallet_details/wallet_detail_screen.dart';

import 'pages/internal_wallet/wallet_details/make_query_smart_contract.dart';
import 'pages/internal_wallet/wallet_details/make_write_smart_contract.dart';
import 'package:aura_sdk/aura_sdk.dart';
import 'package:flutter/material.dart';

import 'pages/internal_wallet/wallet_details/check_aura_balance.dart';
import 'pages/internal_wallet/wallet_details/create_hd_wallet.dart';
import 'pages/internal_wallet/inapp_wallet_page.dart';
import 'pages/internal_wallet/wallet_details/make_a_transaction.dart';
import 'pages/external_wallet/external_wallet_page.dart';
import 'pages/internal_wallet/wallet_details/restore_hd_wallet.dart';

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

  MaterialPageRoute _defaultRouter(Widget child, RouteSettings settings) =>
      MaterialPageRoute(
        builder: (context) {
          return child;
        },
        settings: settings,
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _defaultRouter(const HomePage(), settings);
          case '/inapp-wallet':
            return _defaultRouter(
                const InAppWalletPage(title: 'Digital Wallet Demo'), settings);
          case '/wallet_detail':
            final auraWallet = settings.arguments as AuraWallet;
            return _defaultRouter(
              WalletDetailScreen(
                auraWallet: auraWallet,
              ),
              settings,
            );
          case '/generate-hd-wallet':
            return _defaultRouter(const CreateHdWalletPage(), settings);
          case '/restore-hd-wallet':
            return _defaultRouter(const RestoreHdWalletPage(), settings);
          case '/transaction-history':
            final auraWallet = settings.arguments as AuraWallet;
            return _defaultRouter(
                TransactionHistory(
                  auraWallet: auraWallet,
                ),
                settings);
          case '/check-hd-wallet-balance':
            final auraWallet = settings.arguments as AuraWallet;
            return _defaultRouter(
                CheckHDWalletBalance(
                  auraWallet: auraWallet,
                ),
                settings);
          case '/make-transaction':
            final auraWallet = settings.arguments as AuraWallet;
            return _defaultRouter(
                MakeTransactionPage(
                  auraWallet: auraWallet,
                ),
                settings);
          case '/make-query-smart_contract':
            final auraWallet = settings.arguments as AuraWallet;
            return _defaultRouter(
                MakeQuerySmartContract(
                  auraWallet: auraWallet,
                ),
                settings);
          case '/make-write-smart_contract':
            final auraWallet = settings.arguments as AuraWallet;
            return _defaultRouter(
                MakeWriteSmartContract(
                  auraWallet: auraWallet,
                ),
                settings);
          case '/external-wallet':
            return _defaultRouter(
              const ExternalWalletPage(
                title: "External Wallet Demo",
              ),
              settings,
            );
        }
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
                Navigator.of(context).pushNamed('/inapp-wallet');
              },
              child: const Text('In App wallet'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/external-wallet');
              },
              child: const Text('External wallet'),
            ),
          ],
        ),
      ),
    );
  }
}
