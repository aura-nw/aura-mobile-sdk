import 'package:aura_wallet_example/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:aura_wallet_example/src/application/wrappers/localization/app_localization_provider.dart';
import 'package:aura_wallet_example/src/core/constants/language_key.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int index;
  final void Function(int) onChange;

  const BottomNavigationBarWidget({
    required this.onChange,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return AppLocalizationProvider(
          builder: (language, _) {
            return BottomNavigationBar(
              currentIndex: index,
              backgroundColor: theme.darkColor,
              onTap: onChange,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.wallet,
                  ),
                  label: language
                      .translate(LanguageKey.homeBottomNavigationBarWallet),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.settings,
                  ),
                  label: language
                      .translate(LanguageKey.homeBottomNavigationBarSetting),
                ),
              ],
              selectedItemColor: theme.primaryColor7,
              unselectedItemColor: theme.neutralColor12,
            );
          },
        );
      },
    );
  }
}
