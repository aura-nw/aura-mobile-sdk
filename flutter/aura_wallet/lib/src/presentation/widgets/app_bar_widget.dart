import 'package:aura_wallet/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:aura_wallet/src/aura_navigator.dart';
import 'package:aura_wallet/src/core/typography.dart';
import 'package:aura_wallet/src/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const PrimaryAppBar({
    Key? key,
    required this.title,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return Container(
          padding: EdgeInsets.only(right: 12, left: 12, top: context.statusBar),
          height: preferredSize.height,
          width: preferredSize.width,
          decoration: BoxDecoration(
            color: theme.darkColor,
          ),
          child: Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (onBack != null) {
                    onBack!.call();
                  } else {
                    AppNavigator.pop();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 18,
                    color: theme.lightColor,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  style: AppTypoGraPhy.title2.copyWith(
                    color: theme.lightColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const NormalAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return Container(
          padding: EdgeInsets.only(right: 12, left: 12, top: context.statusBar),
          height: preferredSize.height,
          width: preferredSize.width,
          decoration: BoxDecoration(
            color: theme.darkColor,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: AppTypoGraPhy.title2.copyWith(
              color: theme.lightColor,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
