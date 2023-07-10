import 'package:aura_wallet/src/application/wrappers/app_theme/app_theme.dart';
import 'package:aura_wallet/src/core/typography.dart';
import 'package:flutter/material.dart';

class WalletButtonExecuteWidget extends StatelessWidget {
  final AppTheme theme;
  final String icon;
  final String title;
  final VoidCallback onTap;

  const WalletButtonExecuteWidget({
    required this.theme,
    required this.title,
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.neutralColor21,
        ),
        child: Row(
          children: [
            Image(
              image: AssetImage(icon),
              width: 20,
              height: 20,
              color: theme.lightColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: AppTypoGraPhy.body.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.lightColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
