import 'package:aura_wallet/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:aura_wallet/src/application/wrappers/localization/app_localization_provider.dart';
import 'package:aura_wallet/src/core/constants/language_key.dart';
import 'package:aura_wallet/src/core/typography.dart';
import 'package:aura_wallet/src/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({
    Key? key,
    this.title,
    required this.message,
    this.buttonTitle,
    this.onTap,
  }) : super(key: key);

  final String? title;
  final String message;
  final String? buttonTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return Container(
          decoration: BoxDecoration(
            gradient: theme.gradient1,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AppLocalizationProvider(
                  builder: (language, _) {
                    return Text(
                      title ??
                          language.translate(
                            LanguageKey.dialogMessageDefaultTitle,
                          ),
                      style: AppTypoGraPhy.title1
                          .copyWith(color: theme.lightColor),
                    );
                  },
                ),
                const SizedBox(height: 14),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTypoGraPhy.body.copyWith(
                    color: theme.lightColor,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: AppLocalizationProvider(
                    builder: (language, _) {
                      return AppButton(
                        onPress: () {
                          if (onTap != null) {
                            onTap!();
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        text: buttonTitle ??
                            language.translate(
                                LanguageKey.dialogMessageButtonDefaultTitle),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
