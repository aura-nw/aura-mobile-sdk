import 'package:aura_wallet/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:aura_wallet/src/application/wrappers/localization/app_localization_provider.dart';
import 'package:aura_wallet/src/aura_navigator.dart';
import 'package:aura_wallet/src/core/constants/asset_key.dart';
import 'package:aura_wallet/src/core/constants/language_key.dart';
import 'package:aura_wallet/src/core/typography.dart';
import 'package:aura_wallet/src/core/utils/context_extension.dart';
import 'package:aura_wallet/src/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';

class SetupWalletScreen extends StatelessWidget {
  const SetupWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return Scaffold(
          backgroundColor: theme.darkColor,
          body: SingleChildScrollView(
            child: SizedBox(
              width: context.w,
              height: context.h,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 48,
                ),
                child: Column(
                  children: [
                    const Expanded(
                      child: Center(
                        child: Image(
                          image: AssetImage(
                            ImageKey.logo,
                          ),
                        ),
                      ),
                    ),
                    AppLocalizationProvider(
                      builder: (language, _) {
                        return Text(
                          language.translate(LanguageKey.splashWalletSetup),
                          style: AppTypoGraPhy.h3.copyWith(
                            fontWeight: FontWeight.w500,
                            color: theme.lightColor,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AppLocalizationProvider(
                      builder: (language, p1) {
                        return AppButton(
                          text: language.translate(
                              LanguageKey.splashButtonUsingSeedPhrase),
                          onPress: () => AppNavigator.push(AppRoutes.importWallet),
                          color: theme.neutralColor21,
                          textStyle: AppTypoGraPhy.button16
                              .copyWith(color: theme.lightColor),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    AppLocalizationProvider(
                      builder: (language, _) {
                        return InactiveGradientButton(
                          text: language.translate(
                              LanguageKey.splashButtonCreateNewWallet),
                          onPress: () =>
                              AppNavigator.push(AppRoutes.createWallet),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
