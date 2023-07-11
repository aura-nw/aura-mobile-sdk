import 'package:aura_wallet_example/src/application/wrappers/app_theme/app_theme.dart';
import 'package:aura_wallet_example/src/application/wrappers/localization/app_localization_provider.dart';
import 'package:aura_wallet_example/src/core/constants/language_key.dart';
import 'package:aura_wallet_example/src/core/typography.dart';
import 'package:aura_wallet_example/src/core/utils/app_date_format.dart';
import 'package:aura_wallet_example/src/domain/entities/aura_block.dart';
import 'package:flutter/material.dart';

class WalletBlockWidget extends StatelessWidget {
  final AppTheme theme;
  final AuraBlockData blockData;

  const WalletBlockWidget({
    required this.theme,
    required this.blockData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLocalizationProvider(
      builder: (language, _) => Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  language.translate(LanguageKey.homeWalletBlockWidgetHeight),
                  style: AppTypoGraPhy.caption14.copyWith(
                    color: theme.primaryColor4,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  blockData.block.header.height.toString(),
                  style: AppTypoGraPhy.caption14.copyWith(
                    color: theme.primaryColor6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  language.translate(LanguageKey.homeWalletBlockWidgetProposer),
                  style: AppTypoGraPhy.caption14.copyWith(
                    color: theme.primaryColor4,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  blockData.validatorName,
                  style: AppTypoGraPhy.caption14.copyWith(
                    color: theme.primaryColor6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  language.translate(LanguageKey.homeWalletBlockWidgetTime),
                  style: AppTypoGraPhy.caption14.copyWith(
                    color: theme.primaryColor4,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  AppDateTime.formatDateToString(
                    AppDateTime.parseDateTime(
                      blockData.block.header.time,
                    ),
                    format: AppDateFormatter.yearMonthDayHourMinute,
                  ),
                  style: AppTypoGraPhy.caption14.copyWith(
                    color: theme.primaryColor6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Divider(
            color: theme.lightColor,
            height: 1,
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
