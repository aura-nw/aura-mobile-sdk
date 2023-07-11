import 'package:aura_wallet_example/src/core/app_routes.dart';
import 'package:aura_wallet_example/src/presentation/screens/create_wallet/create_wallet_screen.dart';
import 'package:aura_wallet_example/src/presentation/screens/execute_contract/execute_contract_screen.dart';
import 'package:aura_wallet_example/src/presentation/screens/home/home_screen.dart';
import 'package:aura_wallet_example/src/presentation/screens/import_wallet/import_wallet_screen.dart';
import 'package:aura_wallet_example/src/presentation/screens/scan_qr/scan_qr_screen.dart';
import 'package:aura_wallet_example/src/presentation/screens/send_transaction/send_transaction_screen.dart';
import 'package:aura_wallet_example/src/presentation/screens/setup_wallet/set_up_wallet_screen.dart';
import 'package:aura_wallet_example/src/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

enum AppRoutes {
  splash,
  setupWallet,
  importWallet,
  createWallet,
  home,
  sentTransaction,
  scanQR,
  contract,
}

extension AppRoutesMapper on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.splash:
        return _Path.splash;
      case AppRoutes.setupWallet:
        return _Path.setupWallet;
      case AppRoutes.importWallet:
        return _Path.importWallet;
      case AppRoutes.createWallet:
        return _Path.createWallet;
      case AppRoutes.home:
        return _Path.home;
      case AppRoutes.sentTransaction:
        return _Path.sentTransaction;
      case AppRoutes.scanQR:
        return _Path.scanQR;
      case AppRoutes.contract:
        return _Path.contract;
    }
  }
}

class _Path {
  static const String _base = '/';
  static const String splash = _base;
  static const String setupWallet = '${_base}setup';
  static const String importWallet = '$setupWallet/import';
  static const String createWallet = '$setupWallet/create';
  static const String home = '${_base}home';
  static const String sentTransaction = '$home/sent_transaction';
  static const String scanQR = '$home/scan_QR';
  static const String contract = '$home/contract';
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Path.splash:
        return _defaultRoute(
          const SplashScreen(),
          settings,
        );
      case _Path.setupWallet:
        return _defaultRoute(
          const SetupWalletScreen(),
          settings,
        );
      case _Path.importWallet:
        return _defaultRoute(
          const ImportWalletScreen(),
          settings,
        );
      case _Path.createWallet:
        return _defaultRoute(
          const CreateWalletScreen(),
          settings,
        );
      case _Path.home:
        return _defaultRoute(
          const HomeScreen(),
          settings,
        );
      case _Path.sentTransaction:
        return _defaultRoute(
          const SendTransactionScreen(),
          settings,
        );
      case _Path.scanQR:
        return _defaultRoute(
          const ScanQrScreen(),
          settings,
        );
      case _Path.contract:
        return _defaultRoute(
          const ExecuteContractScreen(),
          settings,
        );
      default:
        return _defaultRoute(
          const SplashScreen(),
          settings,
        );
    }
  }

  static Future? push<T>(AppRoutes route, [T? arguments]) =>
      state?.pushNamed(route.path, arguments: arguments);

  static Future? replaceWith<T>(AppRoutes route, [T? arguments]) =>
      state?.pushReplacementNamed(route.path, arguments: arguments);

  static void pop<T>([T? arguments]) => state?.pop(arguments);

  static void popToFirst() => state?.popUntil((route) => route.isFirst);

  static void replaceAllWith(AppRoutes route) =>
      state?.pushNamedAndRemoveUntil(route.path, (route) => route.isFirst);

  static NavigatorState? get state => navigatorKey.currentState;

  static Route _defaultRoute(
    Widget child,
    RouteSettings settings,
  ) {
    return SlideRoute(
      page: child,
      settings: settings,
    );
  }
}
