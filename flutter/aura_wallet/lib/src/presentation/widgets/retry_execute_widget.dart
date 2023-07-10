import 'package:aura_wallet/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:aura_wallet/src/application/wrappers/localization/app_localization_provider.dart';
import 'package:aura_wallet/src/core/constants/language_key.dart';
import 'package:aura_wallet/src/core/typography.dart';
import 'package:aura_wallet/src/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';

class RetryExecuteWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const RetryExecuteWidget({required this.onRetry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppThemeBuilder(
          builder: (theme) {
            return AppLocalizationProvider(
              builder: (language, _) {
                return AppButton(
                  text: language.translate(LanguageKey.commonWidgetButtonRetry),
                  color: theme.neutralColor21,
                  textStyle:
                      AppTypoGraPhy.button16.copyWith(color: theme.lightColor),
                  onPress: onRetry,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
