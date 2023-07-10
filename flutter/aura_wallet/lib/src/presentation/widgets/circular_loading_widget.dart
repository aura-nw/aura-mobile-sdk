import 'package:aura_wallet/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:flutter/material.dart';

class CircularLoadingWidget extends StatelessWidget {
  const CircularLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppThemeBuilder(
        builder: (theme) {
          return CircularProgressIndicator(
            color: theme.primaryColor4,
            strokeWidth: 3,
          );
        },
      ),
    );
  }
}
