import 'package:aura_wallet_example/src/application/wrappers/app_global_state/app_global_cubit.dart';
import 'package:aura_wallet_example/src/application/wrappers/app_global_state/app_global_state.dart';
import 'package:aura_wallet_example/src/application/wrappers/app_theme/cubit/app_theme_cubit.dart';
import 'package:aura_wallet_example/src/application/wrappers/localization/localization_manager.dart';
import 'package:aura_wallet_example/src/aura_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'application/wrappers/localization/app_translations_delegate.dart';

class AuraWalletApplication extends StatefulWidget {
  const AuraWalletApplication({Key? key}) : super(key: key);

  @override
  State<AuraWalletApplication> createState() => _AuraWalletApplicationState();
}

class _AuraWalletApplicationState extends State<AuraWalletApplication>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.paused:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (WidgetsBinding.instance.focusManager.primaryFocus?.hasFocus ??
            false) {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        navigatorKey: AppNavigator.navigatorKey,
        onGenerateRoute: AppNavigator.onGenerateRoute,
        initialRoute: AppRoutes.splash.path,
        debugShowCheckedModeBanner: false,
        title: 'Aura Wallet',
        locale: AppLocalizationManager.instance.locale,
        localizationsDelegates: const [
          AppTranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizationManager.instance.supportedLang
            .map(
              (e) => Locale(e),
            )
            .toList(),
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (__) => AppThemeCubit(),
              ),
              BlocProvider(
                create: (_) => AppGlobalCubit(),
              ),
            ],
            child: Builder(builder: (context) {
              return MultiBlocListener(
                listeners: [
                  BlocListener<AppGlobalCubit, AppGlobalState>(
                    listenWhen: (previous, current) =>
                        current.status != previous.status,
                    listener: (context, state) {
                      switch (state.status) {
                        case AppGlobalStatus.authorized:
                          AppNavigator.replaceAllWith(AppRoutes.home);
                          break;
                        case AppGlobalStatus.unauthorized:
                          AppNavigator.replaceAllWith(AppRoutes.setupWallet);
                          break;
                      }
                    },
                  ),
                ],
                child: child ?? const SizedBox(),
              );
            }),
          );
        },
      ),
    );
  }
}
