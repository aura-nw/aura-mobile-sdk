import 'package:aura_wallet/src/application/wrappers/app_theme/app_theme.dart';
import 'package:aura_wallet/src/application/wrappers/localization/app_localization_provider.dart';
import 'package:aura_wallet/src/core/constants/language_key.dart';
import 'package:aura_wallet/src/core/typography.dart';
import 'package:aura_wallet/src/core/utils/app_date_format.dart';
import 'package:aura_wallet/src/domain/entities/aura_transaction.dart';
import 'package:flutter/material.dart';

class WalletTransactionWidget extends StatelessWidget {
  final AppTheme theme;
  final AuraTransaction transaction;

  const WalletTransactionWidget({
    required this.theme,
    required this.transaction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLocalizationProvider(
      builder: (language, _) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    language
                        .translate(LanguageKey.homeWalletTransactionWidgetType),
                    style: AppTypoGraPhy.caption14.copyWith(
                      color: theme.primaryColor4,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    transaction.type,
                    style: AppTypoGraPhy.caption14.copyWith(
                      color: transaction.isMsgSend
                          ? theme.basicColorGreen1
                          : transaction.isMsgReceived
                              ? theme.basicColorRed6
                              : theme.neutralColor13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    language.translate(
                        LanguageKey.homeWalletTransactionWidgetAmount),
                    style: AppTypoGraPhy.caption14.copyWith(
                      color: theme.primaryColor4,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    transaction.amount,
                    style: AppTypoGraPhy.caption14.copyWith(
                      color: theme.primaryColor6,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                    language
                        .translate(LanguageKey.homeWalletTransactionWidgetFee),
                    style: AppTypoGraPhy.caption14.copyWith(
                      color: theme.primaryColor4,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    transaction.fee,
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
                    language.translate(LanguageKey.homeWalletStatus),
                    style: AppTypoGraPhy.caption14.copyWith(
                      color: theme.primaryColor4,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    language.translate(transaction.status
                        ? LanguageKey.homeWalletStatusSuccess
                        : LanguageKey.homeWalletStatusFail),
                    style: AppTypoGraPhy.caption14.copyWith(
                      color: transaction.status
                          ? theme.basicColorGreen1
                          : theme.basicColorRed6,
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
                    language
                        .translate(LanguageKey.homeWalletTransactionWidgetTime),
                    style: AppTypoGraPhy.caption14.copyWith(
                      color: theme.primaryColor4,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    AppDateTime.formatDateToString(
                      AppDateTime.parseDateTime(transaction.txData.timeStamp),
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
        );
      },
    );
  }
}
