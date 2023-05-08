import 'package:aura_mobile_sdk/aura_connect_sdk.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuraConnectSdk _connectSdk = AuraConnectSdk();

  AuraWalletInfoData? data;

  @override
  void initState() {
    _connectSdk.init(
      parameter: const AuraConnectSdkParameter(
        callbackUrl: 'app://open.my.app',
        yourAppName: 'Example',
        yourAppLogo: 'logo',
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _connectSdk.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                  await _connectSdk.connectWallet().then((connection) {
                    print(connection.result);
                  }).catchError((error) {
                    print('error --$error');
                  });
                },
                child: const Text('Open'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _connectSdk.requestAccessWallet().then((walletData) {
                    setState(() {
                      data = walletData;
                    });
                  }).catchError((error) {
                    print('request access Wallet error ${error}');
                  });
                },
                child: const Text('Get account'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // final addressWallet = await _connectSdk.transfer(
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
              if (data != null) ...[
                Text('address : ${data!.data.address}'),
                Text('name : ${data!.data.name}'),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
