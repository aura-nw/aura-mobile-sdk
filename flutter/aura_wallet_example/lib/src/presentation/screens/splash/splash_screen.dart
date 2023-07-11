import 'package:aura_wallet_example/app_configs/di.dart';
import 'package:aura_wallet_example/src/application/wrappers/app_global_state/app_global_cubit.dart';
import 'package:aura_wallet_example/src/application/wrappers/app_global_state/app_global_state.dart';
import 'package:aura_wallet_example/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:aura_wallet_example/src/aura_navigator.dart';
import 'package:aura_wallet_example/src/core/constants/asset_key.dart';
import 'package:aura_wallet_example/src/core/screen_loader_mixin.dart';
import 'splash_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_screen_cubit.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with ScreenLoaderMixin {
  final SplashScreenCubit _cubit = getIt.get<SplashScreenCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _cubit.starting();
    });
  }

  @override
  Widget builder(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return BlocProvider.value(
          value: _cubit,
          child: BlocListener<SplashScreenCubit, SplashScreenState>(
            bloc: _cubit,
            listener: (context, state) {
              switch (state.status) {
                case SplashScreenStatus.starting:
                  showLoading();
                  break;
                case SplashScreenStatus.loadWalletSuccess:
                  AppGlobalCubit.of(context).changeState(
                    AppGlobalState(
                      status: AppGlobalStatus.authorized,
                      auraWallet: state.auraWallet,
                    ),
                  );
                  AppNavigator.replaceWith(AppRoutes.home);
                  hideLoading();
                  break;
                case SplashScreenStatus.loadWalletNull:
                  hideLoading();
                  AppNavigator.replaceWith(AppRoutes.setupWallet);
                  break;
              }
            },
            child: Scaffold(
              backgroundColor: theme.darkColor,
              body: const Center(
                child: Image(
                  image: AssetImage(
                    ImageKey.logo,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
