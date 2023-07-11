import 'package:aura_wallet_example/src/application/wrappers/app_global_state/app_global_cubit.dart';
import 'package:aura_wallet_example/src/application/wrappers/app_global_state/app_global_state.dart';
import 'package:aura_wallet_example/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:aura_wallet_example/src/application/wrappers/localization/localization_manager.dart';
import 'package:aura_wallet_example/src/core/constants/language_key.dart';
import 'package:aura_wallet_example/src/presentation/widgets/app_bar_widget.dart';
import 'package:aura_wallet_example/src/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with AutomaticKeepAliveClientMixin {
  final AppLocalizationManager _language = AppLocalizationManager.instance;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppThemeBuilder(
      builder: (theme) {
        return Scaffold(
          appBar: NormalAppBar(
            title: _language.translate(LanguageKey.homeSettingAppBarTitle),
          ),
          backgroundColor: theme.darkColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 40,
            ),
            child: Column(
              children: [
                const Spacer(),
                InactiveGradientButton(
                  text: _language.translate(
                    LanguageKey.homeSettingLogoutButtonTitle,
                  ),
                  onPress: () async {
                    bool? isUserConfirmed = await AppGlobalCubit.of(context)
                        .state
                        .auraWallet
                        ?.removeCurrentWallet();

                    if (isUserConfirmed ?? false) {
                      AppGlobalCubit.of(context).changeState(
                        const AppGlobalState(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
