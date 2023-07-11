import 'package:aura_wallet_example/src/application/wrappers/app_theme/app_theme.dart';
import 'package:aura_wallet_example/src/application/wrappers/localization/app_localization_provider.dart';
import 'package:aura_wallet_example/src/core/constants/language_key.dart';
import 'package:aura_wallet_example/src/core/typography.dart';
import 'package:aura_wallet_example/src/core/utils/context_extension.dart';
import 'package:aura_wallet_example/src/core/utils/dart_core_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WalletReceiveWidget extends StatelessWidget {
  final String address;
  final AppTheme theme;
  final VoidCallback onSwipeUp;

  const WalletReceiveWidget({
    required this.address,
    required this.theme,
    required this.onSwipeUp,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (dragDetail) {
        if (dragDetail.velocity.pixelsPerSecond.dy < -50) {
          onSwipeUp.call();
        }
      },
      child: Container(
        color: theme.darkColor.withOpacity(0.6),
        width: context.w,
        height: context.h,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: QrImageView(
                data: address,
                size: context.w / 2,
                backgroundColor: theme.lightColor,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            AppLocalizationProvider(
              builder: (language, _) {
                return Text(
                  language
                      .translate(LanguageKey.homeWalletReceiveWidgetScanTitle),
                  style: AppTypoGraPhy.subTitle2.copyWith(
                    color: theme.neutralColor9,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: theme.neutralColor19,
                borderRadius: BorderRadius.circular(40),
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: address,
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      address.addressView,
                      style: AppTypoGraPhy.caption14.copyWith(
                        color: theme.lightColor,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Icon(
                      Icons.copy,
                      color: theme.primaryColor5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
